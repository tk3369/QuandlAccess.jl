using QuandlAccess
using DataFrames
using Dates

haskey(ENV, "QUANDL_API_KEY") || error("Please define environment variable: QUANDL_API_KEY")
quandl = Quandl(ENV["QUANDL_API_KEY"])

# get complete time series
quandl(DataSeries("ML", "BBY"))

# date filters
quandl(DataSeries("ML", "BBY"); start_date = Date(2020,1,1))
quandl(DataSeries("ML", "BBY"); start_date = Date(2020,1,1), end_date = Date(2020,1,5))
quandl(DataSeries("ML", "BBY"); start_date = "2020-01-1", end_date = Date(2020,1,5)) # error: bad date format
quandl(DataSeries("ML", "BBY"); start_date = "2020-01-01", end_date = Date(2020,1,5))

# sample frequencies
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "weekly")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "quarterly")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "annual")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "none")

# transforms
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "diff")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "rdiff")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "rdiff_from")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "cumul")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", transform = "normalize")

# order
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", order = "asc")
quandl(DataSeries("ML", "BBY"); start_date = "2018-01-01", collapse = "monthly", order = "desc")

# data table
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY,XOM")])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", "2018-01-09")])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY"), gt("as_of_date", Date(2018,1,9))])
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY"), lt("nav", 280)]) #error: nav not fitlerable
quandl(DataTable("ETFG", "FUND"), filters = [eq("ticker", "SPY")], columns = ["ticker", "nav"])
