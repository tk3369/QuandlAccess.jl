"""
    Quandl

The main access object for querying data from Quandl.com.

# Examples
```julia
quandl(DataSeries("ML", "BBY"))
quandl(DataSeries("ML", "BBY"); start_date = Date(2020,1,1), end_date = Date(2020,1,5))
quandl(DataSeries("ML", "BBY"); collapse = "weekly")
quandl(DataSeries("ML", "BBY"); transform = "diff")
quandl(DataSeries("ML", "BBY"); order = "asc")

quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")], columns = ["ticker", "nav"])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", "2018-01-09")])
```
"""
struct Quandl
    api_key::String
end

Base.show(io::IO, q::Quandl) = print(io, "Quandl(api_key=******)")

"""
    DataSeries

Represents source of a Quandl time series.
"""
struct DataSeries
    database_code::String
    dataset_code::String
end

"""
    DataTable

Represents source of a Quandl database source.
"""
struct DataTable
    database_code::String
    dataset_code::String
end

"""
    FilterCondition{T}

Condition that can be used for filtering rows for a `DataTable` query.
"""
struct FilterCondition{T}
    op::String
    field::String
    value::T
end


