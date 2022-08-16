#
# Tests for struveH and struveK
#

# implement test based on http://dlmf.nist.gov/11.4.E5
for x in 0.1:1.1:150.0
    @test isapprox(Struve.struveH.(0.5, x), sqrt(2 / (BigFloat(x)*pi)) * (1 - cos(BigFloat(x))), rtol=1e-12)
end

# implement test based on http://dlmf.nist.gov/11.4.E9
for x in 0.1:1.1:150.0
    s = Struve.struveH.(3/2, x)
    x = BigFloat(x)
    t = sqrt(x / pi / 2) * (1 + 2/x^2) - sqrt(2 / x / pi) * (sin(x) + cos(x) / x)
    @test isapprox(s, t, rtol=1e-12)
end

for x in 0.1:1.3:80.0, v in 0.1:1.2:40.0
    @show v, x
    t = Struve.struveH_power_series(BigFloat(v), BigFloat(x))
    @test isapprox(Struve.struveH(v, x), t, rtol=1e-11)
end

# testing for struveM which can be prone to cancellation due to subtraction
# in some domains struveL ≈ besseli leading to loss of digits
for x in 0.1:0.15:2.0, v in 0.1:1.2:20.0
    x = x*v
    t = Struve.struveH_power_series(BigFloat(v), BigFloat(x)) - bessely(v, x)
    @test isapprox(Struve.struveK(v, x), t, rtol=1e-9)
end