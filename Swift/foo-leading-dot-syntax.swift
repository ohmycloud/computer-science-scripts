struct Foo {
    static var foo = Foo()
    
    var anotherFoo: Foo { Foo() }
    func getFoo() -> Foo { Foo() }
    var optionalFoo: Foo? { Foo() }
    var fooFunc: () -> Foo { { Foo() } }
    var optionalFooFunc: () -> Foo? { { Foo() } }
    var fooFuncOptional: (() -> Foo)? { { Foo() } }
    subscript() -> Foo { Foo() }
}

let _: Foo = .foo.anotherFoo
let _: Foo = .foo.anotherFoo.anotherFoo.anotherFoo.anotherFoo
let _: Foo = .foo.getFoo()
let _: Foo = .foo.optionalFoo!.getFoo()
let _: Foo = .foo.fooFunc()
let _: Foo = .foo.optionalFooFunc()!
let _: Foo = .foo.fooFuncOptional!()
let _: Foo = .foo.optionalFoo!
let _: Foo = .foo[]
let _: Foo = .foo.anotherFoo[]
let _: Foo = .foo.fooFuncOptional!()[]

struct Bar {
    var anotherFoo = Foo()
}

extension Foo {
    static var bar = Bar()
    var anotherBar: Bar { Bar() }
}

let _: Foo = .bar.anotherFoo
let _: Foo = .foo.anotherBar.anotherFoo
