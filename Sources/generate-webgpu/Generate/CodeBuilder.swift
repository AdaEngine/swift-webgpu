@resultBuilder
struct CodeBuilder {
    static func buildBlock(_ components: String...) -> String {
        return components.joined(separator: "\n")
    }
    
    static func buildEither(first component: String) -> String {
        return component
    }
    
    static func buildEither(second component: String) -> String {
        return component
    }
    
    static func buildArray(_ components: [String]) -> String {
        return components.joined(separator: "\n")
    }
}

func code(@CodeBuilder builder: () -> String) -> String {
    return builder()
}

func indented(@CodeBuilder builder: () -> String) -> String {
    let code = builder()
    let lines = code.split(separator: "\n", omittingEmptySubsequences: false).map { "    " + $0 }
    return lines.joined(separator: "\n")
}

func block(_ prefix: String? = nil, @CodeBuilder builder: () -> String) -> String {
    code {
        if let prefix = prefix {
            "\(prefix) {"
        } else {
            "{"
        }
        indented {
            builder()
        }
        "}"
    }
}

extension String {
    func swiftSafe() -> String {
        if (["repeat", "internal"].contains(self)) {
            return "`\(self)`"
        }
        return self
    }
}