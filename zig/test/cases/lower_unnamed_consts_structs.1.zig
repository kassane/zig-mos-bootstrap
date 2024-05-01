const Foo = struct {
    a: u8,
    b: u32,

    fn first(self: *Foo) u8 {
        return self.a;
    }

    fn second(self: *Foo) u32 {
        return self.b;
    }
};

pub fn main() void {
    var foo = Foo{ .a = 1, .b = 5 };
    assert(foo.first() == 1);
    assert(foo.second() == 5);

    foo.a = 10;
    foo.b = 255;

    assert(foo.first() == 10);
    assert(foo.second() == 255);

    var foo2 = Foo{ .a = 15, .b = 255 };
    assert(foo2.first() == 15);
    assert(foo2.second() == 255);
}

fn assert(ok: bool) void {
    if (!ok) unreachable;
}

// run
//
