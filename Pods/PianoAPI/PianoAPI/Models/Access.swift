import Foundation

@objc(PianoAPIAccess)
public class Access: NSObject, Codable {

    /// The access id
    @objc public var accessId: String? = nil

    /// The access parent id (for accesses from bundled resources)
    @objc public var parentAccessId: String? = nil

    /// Is the access granted
    @objc public var granted: OptionalBool? = nil

    /// The user
    @objc public var user: User? = nil

    /// The resource
    @objc public var resource: Resource? = nil

    /// The access item expire date; null means unlimited
    @objc public var expireDate: Date? = nil

    /// The start date.
    @objc public var startDate: Date? = nil

    /// Can revoke access
    @objc public var canRevokeAccess: OptionalBool? = nil

    /// List of Terms
    @objc public var term: Term? = nil

    public enum CodingKeys: String, CodingKey {
        case accessId = "access_id"
        case parentAccessId = "parent_access_id"
        case granted = "granted"
        case user = "user"
        case resource = "resource"
        case expireDate = "expire_date"
        case startDate = "start_date"
        case canRevokeAccess = "can_revoke_access"
        case term = "term"
    }
}
