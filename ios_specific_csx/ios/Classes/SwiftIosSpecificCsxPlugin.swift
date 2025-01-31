import Flutter
import UIKit

public class SwiftIosSpecificCsxPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_specific_csx", binaryMessenger: registrar.messenger())
        let instance = SwiftIosSpecificCsxPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "addHealthMindfulness":
            let argument = call.arguments as! NSDictionary;
            HealthTool.sharedInstance.addHealthMindfulness(startDateInMill: argument["startDate"] as! Int, endDateInMill: argument["endDate"] as! Int) { (success, errorStr) in
                result(["success":success,"errorDescri":errorStr as Any])
            }
            break;
        case "requestHealthAuthority":
            HealthTool.sharedInstance.requestHealthAuthority { (success, errorStr) in
                result(["success":success,"errorDescri":errorStr as Any])
            }
            break;
        case "getHealthAuthorityStatus":
            let answer = HealthTool.sharedInstance.getHealthAuthorityStatus(subclassificationIndex: call.arguments as! Int).rawValue
            result(answer)
            break;
        case "isHealthDataAvailable":
            let answer = HealthTool.sharedInstance.isHealthDataAvailable()
            result(answer)
            break;
        case "gotoHealthApp":
            guard let url = URL.init(string: "x-apple-health://app/") else {
                result(false)
                fatalError("生成跳转链接失败")
            }
            UIApplication.shared.open(url){(success) in
                result(success)
            }
            break;
        default:
            break;
        }
       
    }
}
