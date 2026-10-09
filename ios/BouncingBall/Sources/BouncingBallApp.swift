import SwiftUI

@main
struct BouncingBallApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    private let diameter: CGFloat = 80
    private let bounceDuration: Double = 1.2
    private let margin: CGFloat = 60

    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { context in
                let t = context.date.timeIntervalSinceReferenceDate
                // Phase 0...1 within one bounce; 4p(1-p) gives a gravity-like parabola.
                let p = t.truncatingRemainder(dividingBy: bounceDuration) / bounceDuration
                let height = 4 * p * (1 - p)
                let floorY = geo.size.height - margin - diameter / 2
                let topY = margin + diameter / 2
                let y = floorY - CGFloat(height) * (floorY - topY)

                Circle()
                    .fill(Color.red)
                    .frame(width: diameter, height: diameter)
                    .position(x: geo.size.width / 2, y: y)
            }
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}
