import CGLFW3

public class GLContext: GLFWObject {
    internal(set) public var pointer: OpaquePointer?
    
    internal init(_ pointer: OpaquePointer?) {
        self.pointer = pointer
    }
    
    public static var current: GLContext {
        GLContext(glfwGetCurrentContext())
    }
    
    public func makeCurrent() {
        glfwMakeContextCurrent(pointer)
    }
    
    public static var syncSwapWithMonitor: Bool = false {
        didSet {
            glfwSwapInterval(syncSwapWithMonitor.int32)
        }
    }
    
    /*public static func setSwapInterval<T: BinaryInteger>(to interval: T) {
        glfwSwapInterval(interval.int32)
    }*/
    
    public typealias Hint = GLFWWindowHints.Hint
    
    private var attributes: GLFWWindow.AttributeManager { .init(pointer) }
    
    public var clientAPI: Hint.ClientAPI {
        Hint.ClientAPI(rawValue: attributes[Constant.clientAPI]) ?? .openGL
    }
    
    public var creationAPI: Hint.ContextCreationAPI {
        Hint.ContextCreationAPI(rawValue: attributes[Constant.contextCreationAPI]) ?? .native
    }
    
    public var openGLVersion: Hint.OpenGLVersion {
        let major = attributes[Constant.contextVersionMajor].int
        let minor = attributes[Constant.contextVersionMinor].int
        return Hint.OpenGLVersion(major: major, minor: minor)
    }
    
    public var openglCompatibility: Hint.OpenGLCompatibility {
        Hint.OpenGLCompatibility(rawValue: attributes[Constant.openglForwardCompatibility]) ?? .backwards
    }
    
    public var debugMode: Bool {
        attributes[Constant.openglDebugContext].bool
    }
    
    public var openglProfile: Hint.OpenGLProfile {
        Hint.OpenGLProfile(rawValue: attributes[Constant.openglProfile]) ?? .any
    }
    
    public var releaseBehavior: Hint.ReleaseBehavior {
        Hint.ReleaseBehavior(rawValue: attributes[Constant.contextReleaseBehavior]) ?? .any
    }
    
    public var suppressErrors: Bool {
        attributes[Constant.contextSuppressErrors].bool
    }
    
    public var robustness: Hint.Robustness {
        Hint.Robustness(rawValue: attributes[Constant.contextRobustness]) ?? .none
    }
}

extension GLFWWindow {
    public var context: GLContext {
        GLContext(pointer)
    }
}