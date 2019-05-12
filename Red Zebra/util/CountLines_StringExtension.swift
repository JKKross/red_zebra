extension String {

    func countAllLines() -> Int {
        
        if self.isEmpty { return 0 }
        
        var total = 1
        
        for i in self {
            if i.isNewline {
                total += 1
            }
        }
        
        if self.last == "\n" {
            total -= 1
        }
        
        return total
    }

    
    
    func countLinesFromBeginning(upTo: Int) -> Int {
        
        if self.isEmpty { return 0 }
        
        var total = 1
        
        var text = self
        let removeLast = text.count - upTo
        text.removeLast(removeLast)
        
        for i in text {
            if i.isNewline {
                total += 1
            }
        }
        
        if text.last == "\n" {
            total -= 1
        }
        
        return total
    }

}
