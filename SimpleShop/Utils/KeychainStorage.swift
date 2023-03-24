import Foundation

enum KeychainError: Error {
    case secCallFailed(OSStatus)
    case notFound
    case badData
    case archiveFailure(Error)
}

protocol KeychainStorage {
    associatedtype DataType: Codable
    
    var account: String { get set }
    var service: String { get set }
    
    func remove() throws
    func retrieve() throws -> DataType
    func store(_ data: DataType) throws
}

extension KeychainStorage {
    func remove() throws {
        let status = SecItemDelete(keychainQuery() as CFDictionary)
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.secCallFailed(status)
        }
    }
    
    func retrieve() throws -> DataType {
        var query = keychainQuery()
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard status != errSecItemNotFound else { throw KeychainError.notFound }
        guard status == noErr else { throw KeychainError.secCallFailed(status) }
        
        do {
            guard
                let dict = result as? [String: AnyObject],
                let data = dict[kSecAttrGeneric as String] as? Data,
                let userData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data
            else {
                throw KeychainError.badData
            }
            let jsonData = try JSONDecoder().decode(DataType.self, from: userData)
            return jsonData
        } catch {
            throw KeychainError.archiveFailure(error)
        }
    }
    
    func store(_ data: DataType) throws {
        var query = keychainQuery()
        
        let archived: AnyObject
        do {
            let jsonData = try JSONEncoder().encode(data)
            archived = try NSKeyedArchiver.archivedData(withRootObject: jsonData, requiringSecureCoding: true) as AnyObject
        } catch {
            throw KeychainError.archiveFailure(error)
        }
        
        let status: OSStatus
        do {
            _ = try retrieve()
            
            let updates = [
                String(kSecAttrGeneric): archived
            ]
            
            status = SecItemUpdate(query as CFDictionary, updates as CFDictionary)
        } catch KeychainError.notFound {
            query[kSecAttrGeneric as String] = archived
            status = SecItemAdd(query as CFDictionary, nil)
        }
        
        guard status == noErr else {
            throw KeychainError.secCallFailed(status)
        }
    }
    
    private func keychainQuery() -> [String: AnyObject] {
        var query: [String: AnyObject] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject
        query[kSecAttrAccount as String] = account as AnyObject
        
        return query
    }
}
