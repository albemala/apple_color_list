import Cocoa
import FlutterMacOS
import AppKit

public class AppleColorListPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger
        let api = AppleColorListPluginImpl()
        AppleColorListApiSetup.setUp(binaryMessenger: messenger, api: api)
    }
}

class AppleColorListPluginImpl: NSObject, AppleColorListApi {
    func readColorList(from path: String) throws -> AppleColorList {
        let filename = URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent

        if let nsColorList = NSColorList(name: filename, fromFile: path) {
            let colors = nsColorList.allKeys.compactMap { colorName -> AppleColor? in
                guard 
                    let color = nsColorList.color(withKey: colorName),
                    let rgbColor = color.usingColorSpace(.genericRGB)
                else { 
                    return nil 
                }
                
                return AppleColor(
                    name: colorName,
                    red: Double(rgbColor.redComponent),
                    green: Double(rgbColor.greenComponent),
                    blue: Double(rgbColor.blueComponent),
                    alpha: Double(rgbColor.alphaComponent)
                )
            }
            
            return AppleColorList(
                name: nsColorList.name ?? filename,
                colors: colors
            )
        } else {
            throw PigeonError(
                code: "READ_ERROR",
                message: "Could not read color list from file: \(path)",
                details: nil
            )
        }
    }

    func writeColorList(_ appleColorList: AppleColorList, to path: String) throws {
        // Create a new color list with the given name
        let nsColorList = NSColorList(name: appleColorList.name)
        
        // Add each color to the list
        for color in appleColorList.colors {
            let nsColor = NSColor(
                colorSpace: .genericRGB,
                components: [
                    CGFloat(color.red),
                    CGFloat(color.green),
                    CGFloat(color.blue),
                    CGFloat(color.alpha)
                ],
                count: 4
            )
            nsColorList.setColor(nsColor, forKey: color.name)
        }
        
        // Write the color list to file
        do {
            try nsColorList.write(to: URL(fileURLWithPath: path))
        } catch {
            throw PigeonError(
                code: "WRITE_ERROR",
                message: "Could not write color list to file: \(path)",
                details: error.localizedDescription
            )
        }
    }
}
