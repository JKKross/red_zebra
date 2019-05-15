extension String {

    func countAllLines() -> Int {
        
        if self.isEmpty { return 0 }
        
        var total = 1
        
        for i in self {
            if i.isNewline {
                total += 1
            }
        }
        
        return total
    }

}
