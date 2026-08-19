//
//  EditProfileView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {

    @Bindable var profile: UserProfileModel
    @Environment(\.dismiss) private var dismiss

    @State private var photoItem: PhotosPickerItem?
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""

    private let beige = Color(red: 244/255, green: 231/255, blue: 213/255)
    private let bg    = Color(red: 240/255, green: 226/255, blue: 208/255)
    private let burgundy = Color(red: 92/255, green: 16/255, blue: 36/255)

    var body: some View {
        NavigationStack {
            ZStack {
                bg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {

                        // Avatar picker
                        PhotosPicker(selection: $photoItem, matching: .images) {
                            avatarView
                                .overlay(alignment: .bottomTrailing) {
                                    cameraIcon
                                }
                        }
                        .padding(.top, 24)

                        // Fields card
                        VStack(spacing: 0) {
                            editRow(icon: "person",        label: "FULL NAME",     text: $fullName)
                            divider
                            editRow(icon: "at",            label: "USERNAME",      text: $username)
                            divider
                            editRow(icon: "envelope",      label: "EMAIL ADDRESS", text: $email, keyboard: .emailAddress)
                            divider
                            editRow(icon: "phone",         label: "PHONE NUMBER",  text: $phone, keyboard: .phonePad)
                        }
                        .background(beige.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 20)

                        // Save button
                        Button { save() } label: {
                            HStack(spacing: 10) {
                                Text("Save Changes")
                                    .font(.system(size: 16, weight: .semibold))
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                            }
                            .foregroundColor(beige)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(burgundy)
                            .clipShape(Capsule())
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(burgundy)
                }
            }
            .onAppear { prefill() }
            .onChange(of: photoItem) { _, item in
                Task {
                    if let data = try? await item?.loadTransferable(type: Data.self) {
                        profile.avatarData = data
                    }
                }
            }
        }
    }

    // MARK: - Sub-views

    private var avatarView: some View {
        Group {
            if let img = profile.avatarData.flatMap({ UIImage(data: $0) }) {
                Image(uiImage: img)
                    .resizable().scaledToFill()
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(burgundy.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(beige)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 3))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }

    private var cameraIcon: some View {
        ZStack {
            Circle()
                .fill(burgundy)
                .frame(width: 30, height: 30)
            Image(systemName: "camera.fill")
                .font(.system(size: 13))
                .foregroundColor(beige)
        }
        .offset(x: 4, y: 4)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color(red: 220/255, green: 197/255, blue: 168/255).opacity(0.6))
            .frame(height: 0.5)
            .padding(.leading, 58)
    }

    private func editRow(
        icon: String,
        label: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 220/255, green: 197/255, blue: 168/255).opacity(0.5))
                    .frame(width: 34, height: 34)
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(burgundy.opacity(0.7))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(burgundy.opacity(0.5))
                    .tracking(0.8)
                TextField("", text: text)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(burgundy)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    // MARK: - Logic

    private func prefill() {
        fullName = profile.fullName
        username = profile.username
        email    = profile.email
        phone    = profile.phone
    }

    private func save() {
        profile.fullName = fullName
        profile.username = username
        profile.email    = email
        profile.phone    = phone
        dismiss()
    }
}
