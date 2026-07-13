//
//  ProfileView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ProfileView: View {

    // SwiftData query – always at most one profile record
    @Query private var profiles: [UserProfile]
    @Environment(\.modelContext) private var modelContext

    @State private var showEdit = false
    @State private var showChangePassword = false
    @State private var photoItem: PhotosPickerItem?

    // Colours exactly matching the reference
    private let bg       = Color(red: 242/255, green: 228/255, blue: 210/255)
    private let cardBg   = Color(red: 248/255, green: 237/255, blue: 224/255)
    private let burgundy = Color(red: 92/255,  green: 16/255,  blue: 36/255)
    private let textDim  = Color(red: 160/255, green: 120/255, blue: 100/255)

    // Lazily create a profile record if none exists yet
    private var profile: UserProfile {
        if let existing = profiles.first { return existing }
        let new = UserProfile(
            fullName: "Your Name",
            username: "username",
            email:    "you@example.com",
            phone:    "+1 (000) 000-0000"
        )
        modelContext.insert(new)
        return new
    }

    var body: some View {
        ZStack {
            bg.ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: – Top Bar
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(burgundy)
                        .padding(10)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())

                    Spacer()

                    Text("OleGrey.")
                        .font(.custom("Georgia", size: 22))
                        .italic()
                        .foregroundColor(burgundy)

                    Spacer()

                    Image(systemName: "bell")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(burgundy)
                        .padding(10)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {

                        // MARK: – Header
                        VStack(spacing: 4) {
                            Text("Account Information")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(burgundy)

                            Text("Manage your private details")
                                .font(.system(size: 13))
                                .foregroundColor(textDim)
                        }
                        .padding(.top, 8)

                        // MARK: – Avatar
                        PhotosPicker(selection: $photoItem, matching: .images) {
                            avatarView
                                .overlay(alignment: .bottomTrailing) { cameraIcon }
                        }
                        .onChange(of: photoItem) { _, item in
                            Task {
                                if let data = try? await item?.loadTransferable(type: Data.self) {
                                    profile.avatarData = data
                                }
                            }
                        }

                        // MARK: – Info Card
                        VStack(spacing: 0) {
                            infoRow(icon: "person",   label: "FULL NAME",     value: profile.fullName)
                            rowDivider
                            infoRow(icon: "at",       label: "USERNAME",      value: profile.username)
                            rowDivider
                            infoRow(icon: "envelope", label: "EMAIL ADDRESS", value: profile.email)
                            rowDivider
                            infoRow(icon: "phone",    label: "PHONE NUMBER",  value: profile.phone)
                        }
                        .background(cardBg)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
                        .padding(.horizontal, 20)

                        // MARK: – Buttons
                        VStack(spacing: 12) {

                            // Edit Profile – filled burgundy
                            Button { showEdit = true } label: {
                                HStack(spacing: 8) {
                                    Text("Edit Profile")
                                        .font(.system(size: 16, weight: .semibold))
                                    Image(systemName: "pencil")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundColor(cardBg)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(burgundy)
                                .clipShape(Capsule())
                            }

                            // Change Password – outlined
                            Button { showChangePassword = true } label: {
                                Text("Change Password")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(burgundy)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 54)
                                    .background(cardBg)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .stroke(burgundy.opacity(0.35), lineWidth: 1.5)
                                    )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            EditProfileView(profile: profile)
        }
    }

    // MARK: – Sub-views

    private var avatarView: some View {
        Group {
            if let img = profile.avatarData.flatMap({ UIImage(data: $0) }) {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    cardBg
                    Image(systemName: "person.fill")
                        .font(.system(size: 44))
                        .foregroundColor(burgundy.opacity(0.35))
                }
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 3))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }

    private var cameraIcon: some View {
        ZStack {
            Circle()
                .fill(burgundy)
                .frame(width: 30, height: 30)
                .shadow(color: burgundy.opacity(0.4), radius: 4, x: 0, y: 2)
            Image(systemName: "camera.fill")
                .font(.system(size: 13))
                .foregroundColor(cardBg)
        }
        .offset(x: 4, y: 4)
    }

    private var rowDivider: some View {
        Rectangle()
            .fill(Color(red: 220/255, green: 197/255, blue: 168/255).opacity(0.7))
            .frame(height: 0.5)
            .padding(.leading, 60)
    }

    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 14) {

            // Icon pill
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(bg.opacity(0.8))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(textDim)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(textDim)
                    .tracking(1.0)

                Text(value.isEmpty ? "—" : value)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(burgundy)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(textDim.opacity(0.6))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

// MARK: – Preview
#Preview {
    ProfileView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
