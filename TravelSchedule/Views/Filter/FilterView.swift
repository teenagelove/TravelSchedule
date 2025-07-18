//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct FilterView: View {
    @Binding var viewModel: RouteViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Время отправления")
                    .font(.bold24)
                    .foregroundStyle(.primary)
                
                VStack(spacing: 16) {
                    ForEach(TimeSlot.allCases, id: \.self) { timeSlot in
                        TimeSlotRow(
                            title: timeSlot.description,
                            isSelected: viewModel.selectedTimeSlots.contains(timeSlot)
                        ) {
                            viewModel.toggleTimeSlot(timeSlot)
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Показывать варианты с пересадками")
                    .font(.bold24)
                    .foregroundStyle(.primary)
                
                VStack(spacing: 16) {
                    RadioButton(
                        title: "Да",
                        isSelected: viewModel.showTransfers
                    ) {
                        viewModel.setShowTransfers(true)
                    }
                    
                    RadioButton(
                        title: "Нет",
                        isSelected: !viewModel.showTransfers
                    ) {
                        viewModel.setShowTransfers(false)
                    }
                }
            }
            
            Spacer()
            
            Button(
                action: {
                    viewModel.applyFilters()
                    dismiss()
                },
                label: {
                    BlueLabel(text: "Применить")
                }
            )
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = RouteViewModel()
    FilterView(viewModel: $viewModel)
}
