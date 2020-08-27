const API_ROOT = "https://www.quandl.com/api/v3"
const SERIES_ROOT = string(API_ROOT, "/datasets")
const DATA_TABLE_ROOT = string(API_ROOT, "/datatables")

function enhance(url::AbstractString, key::AbstractString, value, check::Function)
    value == nothing && return url
    check(value) || throw(ArgumentError("Invalid value for key `$key`: $value"))
    return string(url, "&", key, "=", value)
end

positive_integer(x) = x isa Integer && x > 0

non_negative_integer(x) = x isa Integer && x >= 0

valid_date(x) = x isa Date ||
    (x isa AbstractString && match(r"\d\d\d\d-\d\d-\d\d", x) !== nothing)

valid_order_string(x) = x ∈ ["asc", "desc"]

valid_sample_frequency(x) = x ∈ ["none", "daily", "weekly", "monthly", "quarterly", "annual"]

valid_transform(x) = x ∈ ["none", "diff", "rdiff", "rdiff_from", "cumul", "normalize"]

function make_url(q::Quandl, series::DataSeries;
             limit = nothing, column_index = nothing,
             start_date = nothing, end_date = nothing,
             order = nothing, collapse = nothing, transform = nothing)

    url = "$SERIES_ROOT/$(series.database_code)/$(series.dataset_code).csv?api_key=$(q.api_key)"
    url = enhance(url, "limit", limit, positive_integer)
    url = enhance(url, "column_index", column_index, non_negative_integer)
    url = enhance(url, "start_date", start_date, valid_date)
    url = enhance(url, "end_date", end_date, valid_date)
    url = enhance(url, "order", order, valid_order_string)
    url = enhance(url, "collapse", collapse, valid_sample_frequency)
    url = enhance(url, "transform", transform, valid_transform)
    return url
end

# filter condition operators
eq(x, y) = FilterCondition("=", x, y)
gt(x, y) = FilterCondition(".gt=", x, y)
lt(x, y) = FilterCondition(".lt=", x, y)
gte(x, y) = FilterCondition(".gte=", x, y)
lte(x, y) = FilterCondition(".lte=", x, y)

function enhance(url::AbstractString, cond::FilterCondition)
    return string(url, "&", cond.field, cond.op, cond.value)
end

function make_url(q::Quandl, table::DataTable;
            filters::AbstractVector{T} = FilterCondition[],
            columns::AbstractVector{String} = String[]) where {T <: FilterCondition}

    url = "$DATA_TABLE_ROOT/$(table.database_code)/$(table.dataset_code).csv?api_key=$(q.api_key)"
    for cond in filters
        url = enhance(url, cond)
    end
    if length(columns) > 0
        url = string(url, "&qopts.columns=", join(columns, ","))
    end
    return url
end

strip_key(url::AbstractString) = replace(url, r"api_key=[0-9a-zA-Z]*" => "api_key=xxxxxx")

function (q::Quandl)(x::T; verbose = false, kwargs...) where {T <: Union{DataSeries, DataTable}}
    url = make_url(q, x; kwargs...)
    verbose && @info "Requesting data" strip_key(url)
    try
        response = HTTP.get(url)
        return DataFrame(CSV.File(response.body))
    catch ex
        @error "Unable to download data" ex
        return nothing
    end
end
