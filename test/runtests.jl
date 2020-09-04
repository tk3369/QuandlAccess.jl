using QuandlAccess
using QuandlAccess: enhance, positive_integer, non_negative_integer, valid_date, make_url
using Dates
using Test

@testset "QuandlAccess.jl" begin

    @testset "URL construction" begin

        @test enhance("abc", "k", nothing, positive_integer) == "abc"

        @test enhance("abc", "k", 1, positive_integer) == "abc&k=1"
        @test_throws ArgumentError enhance("abc", "k", 0, positive_integer)

        @test enhance("abc", "k", 0, non_negative_integer) == "abc&k=0"
        @test_throws ArgumentError enhance("abc", "k", -1, non_negative_integer)

        @test valid_date("2020-01-01") == true
        @test valid_date("2020-1-2") == false
        @test valid_date(Date(2020,1,1)) == true
        @test valid_date(DateTime(2020,1,1,0,0,0)) == false

        let q = Quandl("abc"), s = TimeSeries("s/t"), t = DataTable("x/y")
            @test endswith(make_url(q, s; start_date = "2020-01-01"), "start_date=2020-01-01")
            @test endswith(make_url(q, s; end_date = "2020-01-01"), "end_date=2020-01-01")
            @test endswith(make_url(q, s; collapse = "monthly"), "collapse=monthly")
            @test endswith(make_url(q, s; transform = "diff"), "transform=diff")
            @test endswith(make_url(q, s; limit = 2), "limit=2")
            @test endswith(make_url(q, s; column_index = 2), "column_index=2")
            @test endswith(make_url(q, s; order = "asc"), "order=asc")

            @test endswith(make_url(q, t; filters=[eq("a","b")]), "a=b")
            @test endswith(make_url(q, t; filters=[lt("a","b")]), "a.lt=b")
            @test endswith(make_url(q, t; filters=[gt("a","b")]), "a.gt=b")
            @test endswith(make_url(q, t; filters=[lte("a","b")]), "a.lte=b")
            @test endswith(make_url(q, t; filters=[gte("a","b")]), "a.gte=b")
            @test endswith(make_url(q, t; columns=["a","b"]), "columns=a,b")
        end
    end

end
