//
//  TrackersViewController+ContextMenu.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import UIKit

extension TrackersViewController {
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: nil) { _ in
            self.makeContextMenu(for: indexPath)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell else {
            return nil
        }
        
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        parameters.visiblePath = UIBezierPath(roundedRect: cell.mainView.bounds, cornerRadius: cell.mainView.layer.cornerRadius)
        
        return UITargetedPreview(view: cell.mainView, parameters: parameters)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? TrackerCollectionViewCell else {
            return nil
        }
        
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        parameters.visiblePath = UIBezierPath(roundedRect: cell.mainView.bounds, cornerRadius: cell.mainView.layer.cornerRadius)
        
        return UITargetedPreview(view: cell.mainView, parameters: parameters)
    }
    
    private func makeContextMenu(for indexPath: IndexPath) -> UIMenu {
        guard let tracker = collectionViewModel?.item(at: indexPath)
        else {
            Log.warn(message: "failed to find item at \(indexPath.row)")
            return UIMenu()
        }
        
        
        let pinMessage = tracker.isPinned ? LocalizedString.Trackers.ContextMenu.unpin : LocalizedString.Trackers.ContextMenu.pin
        
        let pinAction = UIAction(
            title: pinMessage) { _ in
                self.pinItem(at: indexPath)
            }
        
        let editAction = UIAction(
            title: LocalizedString.Trackers.ContextMenu.edit) { _ in
                self.editItem(at: indexPath)
            }
        
        let deleteAction = UIAction(title: LocalizedString.Trackers.ContextMenu.delete,
                                    attributes: .destructive) { _ in
            self.deleteItem(at: indexPath)
        }
        
        return UIMenu(title: "", children: [pinAction, editAction, deleteAction])
    }
    
    private func pinItem(at indexPath: IndexPath) {
        guard let tracker = collectionViewModel?.item(at: indexPath)
        else {
            Log.warn(message: "failed to find item at \(indexPath.row)")
            return
        }
        viewModel?.togglePinned(for: tracker.id)
    }
        
    private func editItem(at indexPath: IndexPath) {
        Log.info(message: "reporting edit event")
        AnalyticsService.shared.trackEvent(event: .click, params: AnalyticsEventData.MainScreen.clickEdit)
        
        guard let tracker = collectionViewModel?.item(at: indexPath),
              let category = collectionViewModel?.categoryForItem(at: indexPath)
        else {
            Log.warn(message: "failed to find item at \(indexPath.row)")
            return
        }
        
        let schedule = tracker.schedule?.rawValue ?? 0
        let count = trackerRecordStore?.count(by: tracker.id) ?? 0
        
        let updateTrackerViewController = TrackerViewController()
        updateTrackerViewController.selectedDate = selectedDate
        updateTrackerViewController.eventType = (schedule > 0) ? .updateHabit : .updateOneOff
        updateTrackerViewController.delegate = viewModel
        updateTrackerViewController.modalPresentationStyle = .pageSheet
        updateTrackerViewController.configure(with: tracker, category: category, count: count)
        present(updateTrackerViewController, animated: true, completion: nil)
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        guard let tracker = collectionViewModel?.item(at: indexPath)
        else {
            Log.warn(message: "failed to find item at \(indexPath.row)")
            return
        }
        
        if let viewModel {
            self.showDeleteAlert(for: tracker.id, onDelete: viewModel.deleteTracker)
        }
    }
    
    private func showDeleteAlert(for id: UUID, onDelete: @escaping (UUID) -> Void) {
        let alertController = UIAlertController(
            title: LocalizedString.Trackers.DeleteAlert.title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let deleteAction = UIAlertAction(
            title: LocalizedString.Trackers.DeleteAlert.actionDelete,
            style: .destructive
        ) { _ in
            Log.info(message: "reporting delete event")
            AnalyticsService.shared.trackEvent(event: .click, params: AnalyticsEventData.MainScreen.clickDelete)
            onDelete(id)
        }
        
        let cancelAction = UIAlertAction(
            title: LocalizedString.Trackers.DeleteAlert.actionCancel,
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
