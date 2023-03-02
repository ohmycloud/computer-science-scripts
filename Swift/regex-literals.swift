func parseLine(_ line: Substring) throws -> MailmapEntry {

    let regex = /\h*([^<#]+?)??\h*<([^>#]+)>\h*(?:#|\Z)/

    guard let match = line.prefixMatch(of: regex) else {
        throw MailmapError.badLine
    }

    return MailmapEntry(name: match.1, email: match.2)
}
