struct Squares
    count::Int
end

Base.iterate(S::Squares, state = 1) = state > S.count ? nothing : (state*state, state + 1)

for i in Squares(4)
    println(i)
end

println(25 in Squares(10))

using Statistics

println(std(Squares(100)))

println(isvalid('和'))
println(codepoint('A'))
println(codepoint('楽'))
println(length("乐土，1", 1,2))
println(sizeof("土"))

println( "Helo" * " World" )
println("-" ^ 12)
println(string("a", 1, true))

println(repeat('+', 12))
println(repr("12345"))