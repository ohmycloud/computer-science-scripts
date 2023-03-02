// All of class's stored properties - including any properties the class inherts from its superclas - must be assigned an initial value during initialization

// designated initializers and convenience initializers
// designated initializer are the primary initializers for a class
// a designated initializer fully initializers all properties introduced by that class and call an approproate superclass initializers to continue the initalization process up the superclass chain

// Every class must have at least one designated initializer
// In some case, this requirment is satisfiled by inheriting one or more designated initializers from a superclass
// Convenience initializers are secondary, supporting initializers for a class
// You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializers's parameters set to default values.
// You can also define a convenience initializer to create an instance of that class for a specific use case or input value type

// Rule 1: A designated initializer must call a designated initializer from its immediate superclass.
// Swift subclasses don't inhert their superclass initializers by default 
