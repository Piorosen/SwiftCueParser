//
//  CueSheet.swift
//  CueSheet
//
//  Created by Aoikazto on 2020/06/07.
//  Copyright © 2020 Aoikazto. All rights reserved.
//

import Foundation

public class CueSheetParser {
    public init() {
    }
    
    /**
     파일 데이터를 입력을 받은 후 라인 데이터로 분리를 하고, 빈 공간, 빈 데이터가 있다면 필터를 통하여 삭제를 합니다.
     
     - Parameters:
     - data: 문자열 데이터
     - encoding: 인코딩 방식
     
     - Returns:
     모든 데이터를 라인 데이터로 변환 한 뒤 반환 합니다.
     */
    private func read(_ data:String, _ encoding:String.Encoding = .utf8) -> [String] {
        return data.components(separatedBy: .newlines)
            .map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    
    public func load(path:URL, encoding:String.Encoding = .utf8) throws -> CueSheet {
        guard let data = try? String(contentsOf: path, encoding: encoding) else {
            throw CSError.expireUrl(url: path)
        }
        
        return try self.load(data: data, encoding: encoding)
    }
    
    public func load(data:String, encoding:String.Encoding = .utf8) throws -> CueSheet {
        if data.isEmpty {
            throw CSError.blankData
        }
        
        let splited = try split(data: read(data, encoding))
        
        let m = try metaParser(data: splited.meta)
        let r = try remParser(data: splited.rem)
        let f = try fileParser(file: splited.file, track: splited.track)
        
        return CueSheet(meta: m, rem: r, file: f)
    }
    
    
}
