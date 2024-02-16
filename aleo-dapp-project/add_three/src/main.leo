// The 'add_three' program.
program add_three.aleo {
    transition main(public a: u32, b: u32, c: u32) -> u32 {
        let d: u32 = a + b + c;
        return d;
    }
}
