//
//  File.swift
//  
//
//  Created by Aoikazto on 2020/10/27.
//


public enum CSRemKey: Hashable, CaseNamable {
    public init(_ data: String) {
        switch data.lowercased() {
        case "title":
            self = .title
        case "genre":
            self = .genre
        case "date":
            self = .date
        case "discId":
            self = .discId
        case "comment":
            self = .comment
        case "composer":
            self = .composer
            
        default:
            self = .others(data)
        }
    }
    
    case title
    case genre
    case date
    case discId
    case comment
    case composer
    case others(_ key: String)
    
    public var caseName:String {
        switch self {
        case .others(let key):
            return key
        default:
            return String(describing: self)
        }
    }
}
