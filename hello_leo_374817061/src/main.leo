// The 'hello_leo_won' program.
program hello_leo_won.aleo {
    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
}
