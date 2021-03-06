# QuandlAccess.jl

[![Build Status](https://github.com/tk3369/QuandlAccess.jl/workflows/CI/badge.svg)](https://github.com/tk3369/QuandlAccess.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tk3369/QuandlAccess.jl/coverage.svg?branch=master)](http://codecov.io/github/tk3369/QuandlAccess.jl?branch=master)
![Project Status](https://img.shields.io/badge/status-new-green)

This package provides convenient access to [Quandl](https://www.quandl.com/)
data service.

## Usage

Create a `Quandl` object with your API key:

```julia
quandl = Quandl(ENV["QUANDL_API_KEY"])
```

#### Time Series API

Submit query using `TimeSeries` object. Standard query options are available.

```julia
# get complete time series
quandl(TimeSeries("ML/BBY"))

# date filters (works with both Date or String)
quandl(TimeSeries("ML/BBY"); start_date = Date(2020,1,1))
quandl(TimeSeries("ML/BBY"); start_date = Date(2020,1,1), end_date = Date(2020,1,5))
quandl(TimeSeries("ML/BBY"); start_date = "2020-01-01", end_date = Date(2020,1,5))

# sample frequencies
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "weekly")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "quarterly")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "annual")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "none")

# transforms
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "diff")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "rdiff")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "rdiff_from")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "cumul")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "normalize")

# order
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", order = "asc")
quandl(TimeSeries("ML/BBY"); start_date = "2018-01-01", collapse = "monthly", order = "desc")
```

#### Data Table API

Submit query using `Table` object. For filters, the predicate opertors can be `eq`, `gt`, `gte`, `lt`, or `lte`.

```julia
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY")])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY,XOM")])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", "2018-01-09")])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", Date(2018,1,9))])
quandl(Table("ETFG/FUND"), filters = [eq("ticker", "SPY")], columns = ["ticker", "nav"])
```
