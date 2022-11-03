import PianoOAuth
import PianoAPI



class TokenService: ObservableObject, PianoIDDelegate {

    private let logger: Logger

    @Published private(set) var initialized = false
    @Published private(set) var token: PianoIDToken?

    init(logger: Logger) {
        self.logger = logger

        /// Set Piano ID settings
        PianoID.shared.endpointUrl = Settings.endpoint.api
        PianoID.shared.aid = Settings.aid
        PianoID.shared.delegate = self

        token = PianoID.shared.currentToken
        PianoAPI.shared.initialize(endpoint: PianoAPIEndpoint.production)
        
        request { _ in
            DispatchQueue.main.async {
                self.initialized = true
            }
        }
    }

    func request(completion: @escaping (PianoIDToken?) -> Void) {
        if let t = token {
            if t.isExpired {
                /// Refresh token if expired
                PianoID.shared.refreshToken(t.refreshToken) { token, error in
                    if let t = token {
                        self.token = t
                        completion(t)
                        return
                    }

                    self.logger.error(error, or: "Invalid result")
                    completion(nil)
                }
            } else {
                completion(t)
            }
            return
        }

        completion(nil)
    }

    /// Sign In callback
    func signIn(result: PianoIDSignInResult!, withError error: Error!) {
        if let r = result {
            token = r.token
        } else {
            logger.error(error, or: "Invalid result")
        }
    }

    /// Sign Out callback
    func signOut(withError error: Error!) {
        logger.error(error, or: "Invalid result")
        token = nil
    }

    /// Cancel callback
    func cancel() {
    }
    
    func printToken(token:String){
        logger.debug(token)
    }
    
    func covertJSON(data:AccessDTO) -> AnyObject{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let createDate = formatter.string(from: (data.user?.createDate)!)
        
        let user:[String:String]=[
            "uid":data.user?.uid ?? "",
            "email":data.user?.email ?? "",
            "firstName":data.user?.firstName ?? "",
            "lastName":data.user?.lastName ?? "",
            "personalName":data.user?.personalName ?? "",
            "createDate":createDate
        ]
        
        let resource:[String:String]=[
            "rid":data.resource?.rid ?? "",
            "aid":data.resource?.aid ?? "",
            "name":data.resource?.name ?? "",
            "_description":data.resource?._description ?? "",
            "imageUrl":data.resource?.imageUrl ?? ""
        ]
        
        let term:[String:String]=[
            "termId":data.term?.termId ?? "",
            "aid":data.term?.aid ?? "",
            "type":data.term?.type ?? "",
            "name":data.term?.name ?? "",
            "_description":data.term?._description ?? "",
            "createDate":formatter.string(from: (data.term?.createDate)!)
        ]
        
        let jsonObject: [String: Any] = [
            "accessId":data.accessId,
            "parentAccessId":data.parentAccessId,
            "granted":data.granted?.value,
            "user":user,
            "resource":resource,
            "expireDate":data.expireDate,
            "startDate":data.startDate,
            "canRevokeAccess":data.canRevokeAccess?.value,
            "term":term
            
        ]

        let valid = JSONSerialization.isValidJSONObject(jsonObject) // true
        print(valid)
        return jsonObject as AnyObject
    }
    
    func getList(token:String){
        logger.debug(token)
     
        PianoAPI.shared.access.list(aid: "yTcW8MY0pu", userToken:token, completion: {data,error in
            if let error = error {
                print("err")
                print(error)
                           
            }else{
                print("helo")
                print(data?.count)
                for val in data ?? [] {
                    print(self.covertJSON(data:val))
                }
            }
            
//            self.printToken(token: token)
            
        })
        
    }
}
