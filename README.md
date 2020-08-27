# QuandlAccess.jl

[![Travis Build Status](https://travis-ci.org/tk3369/QuandlAccess.jl.svg?branch=master)](https://travis-ci.org/tk3369/QuandlAccess.jl)
[![codecov.io](http://codecov.io/github/tk3369/QuandlAccess.jl/coverage.svg?branch=master)](http://codecov.io/github/tk3369/QuandlAccess.jl?branch=master)
![Project Status](https://img.shields.io/badge/status-new-green)

This package provides convenient access to [Quandl](https://www.quandl.com/)
data service.

## Usage

Create a `Quandl` object with your API key:

```julia
quandl = Quandl("xxxxxxxxxxxxxxxxxx")
```

Some examples for Time Series API:

```julia
quandl(DataSeries("ML", "BBY"))
quandl(DataSeries("ML", "BBY"); start_date = Date(2020,1,1), end_date = Date(2020,1,5))
quandl(DataSeries("ML", "BBY"); collapse = "weekly")
quandl(DataSeries("ML", "BBY"); transform = "diff")
quandl(DataSeries("ML", "BBY"); order = "asc")
```

Some examples for Data Table API:

```julia
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")], columns = ["ticker", "nav"])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", "2018-01-09")])
```
