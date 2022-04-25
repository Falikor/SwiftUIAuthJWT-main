//
//  File.swift
//  SwiftClient
//
//  Created by 19494115 on 24.04.2022.
//

import SwiftUI

public extension View {
    func state(
        _ state: Binding<ScreenViewState>,
        backgroundColor: Color = Color(.systemGroupedBackground)
    ) -> some View {
        StatefulScreenView(state: state, backgroundColor: backgroundColor) { self }
    }
}

public enum ScreenViewState {
    // swiftlint:disable enum_case_associated_values_count
    case loadingWithDelay(delayTime: Int, contentOverlayColor: Color)
    case customAlert(title: String, description: String?, completion: (() -> Void)? = nil)
    case actionError(description: String?, buttonText: String? = nil, completion: (() -> Void)? = nil)
    case emptySearch(text: String? = nil)
    case loadingWith(text: String)
    case loading
    case loaded
    case customizableAlert(
        title: String,
        description: String? = nil,
        buttonText: String? = nil,
        action: (() -> Void)? = nil
    )
}

struct StatefulScreenView<Content: View>: View {
    @Binding private var state: ScreenViewState

    private let content: Content
    private let backgroundColor: Color

    init(
        state: Binding<ScreenViewState>,
        backgroundColor: Color,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.content = content()
        self._state = state
    }

    var body: some View {
        ZStack {
            content
            overlays()
        }
    }

    func overlays() -> AnyView {
        switch state {
        case .loading:
            return activityIndicatorView(with: nil)

        case let .loadingWith(text):
            return activityIndicatorView(with: text)

        case let .loadingWithDelay(delayTime, contentOverlayColor):
            // Show indicator after some delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delayTime)) {
                if case .loadingWithDelay = self.state {
                    // If screen state hasn't changed after delay(still loading) we show loading state
                    self.state = .loading
                } else { // If screen state is no longer .loadingWithDelay(loaded) we do nothing
                    return
                }
            }
            // Cover content with some color instantly and then after delay show loading indicator (above)
            return contentOverlayColor.eraseToAnyView()

        case .loaded:
            return Color.clear.eraseToAnyView()

        case let .customAlert(title, description, completion):
            return alert(with: title, and: description, completion: completion)

        case let .actionError(description, buttonText, completion):
            return alert(
                with: description,
                and: "",
                buttonText: buttonText,
                completion: completion
            )
        case let .emptySearch(text):
            return emptySearch(text: text)
        case let .customizableAlert(
            title,
            description,
            buttonText,
            action
        ):
            return alert(
                with: title,
                and: description,
                buttonText: buttonText,
                completion: action
            )
        }
    }

    private func activityIndicatorView(with text: String?) -> AnyView {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.vertical)

            ActivityIndicatorWithTextView(text: text)
        }
        .eraseToAnyView()
    }

    // swiftlint:disable line_length
    private func alert(
        with title: String?,
        and description: String?,
        buttonText: String? = nil,
        completion: (() -> Void)? = nil
    ) -> AnyView {
        Rectangle()
            .frame(width: 0, height: 0)
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text(title ?? "Повторите, пожалуйста"),
                    message: Text(description ?? "Произошла ошибка. Если она повторяется, напишите о ней через обратную связь в меню приложения."),
                    dismissButton: .default(Text(buttonText ?? "хорошо")) { self.state = .loaded; completion?() }
                )
            }
            .eraseToAnyView()
    }

    private func emptySearch(text: String?) -> AnyView {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.vertical)

            VStack(spacing: 16) {
                Image(systemName: "doc.text.magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundColor(Color(.systemGray3))
                Text(text ?? "Ничего не нашлось\n\nПроверьте запрос на опечатки\nили попробуйте его сократить")
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 76)
                    .font(.subheadline)
            }
        }
        .eraseToAnyView()
    }
}

extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

public struct ActivityIndicatorWithTextView: View {
    @Binding private var isAnimating: Bool
    private let text: String?

    public init(
        isAnimating: Binding<Bool> = .constant(true),
        text: String? = nil
    ) {
        self._isAnimating = isAnimating
        self.text = text
    }

    public var body: some View {
        VStack {
            ActivityIndicatorView(
                isAnimating: $isAnimating,
                style: .medium
            )
            Text(text ?? "ЗАГРУЗКА")
                .font(.caption)
                .foregroundColor(Color(UIColor.systemGray))
        }
    }
}

struct ActivityIndicatorWithTextView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorWithTextView()
    }
}

public struct ActivityIndicatorView: UIViewRepresentable {
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor?
    @Binding private var isAnimating: Bool

    public init(
        isAnimating: Binding<Bool> = .constant(true),
        style: UIActivityIndicatorView.Style = .medium,
        color: UIColor? = nil
    ) {
        self._isAnimating = isAnimating
        self.style = style
        self.color = color
    }

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        if let color = color {
            view.color = color
        }
        return view
    }

    public func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicatorView>
    ) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
