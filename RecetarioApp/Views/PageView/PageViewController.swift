//
//  PageViewController.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        context.coordinator.parent = self
        
        // Mantener las instancias de los controladores para no romper la identidad
        // requerida por UIPageViewController ni causar inconsistencias de estado.
        if context.coordinator.controllers.count != pages.count {
            context.coordinator.controllers = pages.map { UIHostingController(rootView: $0) }
        } else {
            for (index, page) in pages.enumerated() {
                (context.coordinator.controllers[index] as? UIHostingController<Page>)?.rootView = page
            }
        }
        
        guard !context.coordinator.controllers.isEmpty else { return }
        
        let safeIndex = min(max(currentPage, 0), context.coordinator.controllers.count - 1)
        let targetController = context.coordinator.controllers[safeIndex]
        
        // Solo actualizar si el controlador visible actual difiere del objetivo,
        // evitando interrumpir la animación/gesto en curso del usuario.
        if pageViewController.viewControllers?.first !== targetController {
            pageViewController.setViewControllers(
                [targetController],
                direction: .forward,
                animated: false
            )
        }
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
            self.controllers = pageViewController.pages.map { UIHostingController(rootView: $0) }
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), !controllers.isEmpty else {
                return nil
            }
            if index == 0 {
                // UIPageViewController crasheará con NSInternalInconsistencyException si
                // controllers.count < 3 y se retorna controllers.last (ya que sería idéntico al controlador siguiente).
                return controllers.count >= 3 ? controllers.last : nil
            }
            return controllers[index - 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), !controllers.isEmpty else {
                return nil
            }
            if index + 1 == controllers.count {
                // Mismo motivo: evitar retornar el mismo controlador para 'before' y 'after'.
                return controllers.count >= 3 ? controllers.first : nil
            }
            return controllers[index + 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool
        ) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
