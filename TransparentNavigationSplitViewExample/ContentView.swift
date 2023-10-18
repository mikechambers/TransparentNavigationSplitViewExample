import SwiftUI
import SwiftUIIntrospect

struct ContentView: View {
    var body: some View {
		ZStack {
			Color.green
		
		
		NavigationSplitView {
			Text("Sidebar")
		} content: {
			Text("Content")
		} detail : {
			Text("detail")
		}.introspect(.navigationSplitView, on: .macOS(.v14)) { split in
			
			let c = split.delegate as! NSViewController
			
			   let removeBackgrounds = {
			
				   c.children.forEach { controller in
					   controller.parent?.view.wantsLayer = true
					   controller.parent?.view.layer?.backgroundColor = bgColor
					   controller.view.clearBackgrounds()
				   }
					
			   }
			   
			   removeBackgrounds() // run now...
			   DispatchQueue.main.async(execute: removeBackgrounds)
		   }
		}
    }
}

#Preview {
    ContentView()
}


let bgColor = NSColor.clear.cgColor
private extension NSView {
	func clearBackgrounds() {
		wantsLayer = true
		layer?.backgroundColor = bgColor
		for subview in subviews {
			subview.clearBackgrounds()
		}
	}
}
