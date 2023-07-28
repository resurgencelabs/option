use dep::std;

struct Option<T> {
    null: bool,
    else_value: T,
}


// Returns true if the option is null
fn isNull<T>(o: Option<T>) -> bool {
    o.null
}


// Returns false if the option is null
fn isSome<T>(o: Option<T>) -> bool {
    !o.null
}


// Gets the value of the option, or the default value specified if it is null
fn get<T>(o: Option<T>, def: T) -> T {
    if (o.null){
        def
    }
    else {
        o.else_value
    }
}


// Creates a non null option with the given value
fn make<T>(n: T) -> Option<T> {
    let op = Option {
        null: false,
        else_value: n,
    };
    op
}


// Unwraps the option to the underlying type. Panics if null
fn unwrap<T>(o: Option<T>) -> T {
    assert (!o.null);
    o.else_value
}


// Panics if the option is null
fn assertSome<T>(o: Option<T>) {
    assert (!o.null);
}


// Panic if the option is NOT null
fn assertNull<T>(o: Option<T>) {
    assert (o.null);
}



// Creates a null option of said underlying type. Panics if that type has no default value
fn makeNull<T>() -> Option<T> {
    let zero: T = std::unsafe::zeroed();
    let op = Option {
        null: true,
        else_value: zero,
    };
    op
}


// To be used in case there isn't a default zero value for the type T
fn makeNull2<T>(garb: T) -> Option<T> {
    
    let op = Option {
        null: true,
        else_value: garb,
    };
    op
}


// Returns false if at least one of the input options is not null
fn unionNull<T>(o1: Option<T>, o2: Option<T>) -> bool {
    if o1.null {
        if o2.null {
            true
        }
        else {
            false
        }
    }
    else {
        if o2.null {
           false 
        }
        else {
           false
        }
    }
}

// Returns true if at least one of the input options is null
fn intersectionNull<T>(o1: Option<T>, o2: Option<T>) -> bool {
    if o1.null {
        if o2.null {
            true
        }
        else {
            true
        }
    }
    else {
        if o2.null {
           true 
        }
        else {
           false
        }
    }
}


#[test]
fn test_create() {
    let k = make(7);
    assert (isSome(k));
}


#[test]
fn test_create_null() {
    let k: Option<u32> = makeNull();
    assert (isNull(k));
}

#[test]
fn test_default() {
    let k: Option<u32> = makeNull();
    assert (k.else_value == 0);
}

#[test]
fn test_unwrap() {
    let k = make(7);
    let unw = unwrap(k);
    assert (unw == 7);
}

#[test]
fn test_get1() {
    let k = make(7);
    let g = get(k, 23);
    assert(g == 7);
}

#[test]
fn test_get2() {
    let k: Option<u32> = makeNull();
    let g = get(k, 23);
    assert(g == 23);
}

#[test]
fn test_unionnull() {
    let k = make(7);
    let l: Option<u32> = makeNull();
    let un = unionNull(k, l);
    assert(!un);
}


#[test]
fn test_intersectionnull() {
    let k = make(7);
    let l: Option<u32> = makeNull();
    let inter = intersectionNull(k, l);
    assert(inter);
}