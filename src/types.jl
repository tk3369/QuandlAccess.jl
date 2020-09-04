"""
    Quandl

The main access object for querying data from Quandl.com.

# Examples
```julia
quandl(TimeSeries("ML/BBY"))
quandl(TimeSeries("ML/BBY"); start_date = Date(2020,1,1), end_date = Date(2020,1,5))
quandl(TimeSeries("ML/BBY"); collapse = "weekly")
quandl(TimeSeries("ML/BBY"); transform = "diff")
quandl(TimeSeries("ML/BBY"); order = "asc")

quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY")])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY")], columns = ["ticker", "nav"])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", "2018-01-09")])
```
"""
struct Quandl
    api_key::String
end

Base.show(io::IO, q::Quandl) = print(io, "Quandl(api_key=******)")

"""
    TimeSeries

Represents source of a Quandl time series.
"""
struct TimeSeries
    code::String
end

"""
    Table

Represents source of a Quandl database source.
"""
struct Table
    code::String
end

"""
    FilterCondition{T}

Condition that can be used for filtering rows for a `Table` query.
"""
struct FilterCondition{T}
    op::String
    field::String
    value::T
end


