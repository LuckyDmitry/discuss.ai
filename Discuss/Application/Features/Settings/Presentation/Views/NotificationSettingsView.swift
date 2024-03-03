//
//  NotificationSettingsView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 14.05.2023.
//

import SwiftUI

struct NotificationSettingsView: View {
  
  @State
  var notificationsTime: Date = .now
  var onSavePressed: (Date) -> Void
    
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      PrimaryText("Choose time for reminders")
        .font(.sfPro(.bold, size: 20))
        .padding(.bottom, 4)
      DatePicker("", selection: $notificationsTime, displayedComponents: .hourAndMinute)
        .tint(.white)
        .datePickerStyle(WheelDatePickerStyle())
      PrimaryButton(action: {
        onSavePressed(notificationsTime)
      }, text: "Save")
        .padding(.top, 40)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
  }
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
      NotificationSettingsView(
        notificationsTime: .now,
        onSavePressed: { _ in }
      )
    }
}
