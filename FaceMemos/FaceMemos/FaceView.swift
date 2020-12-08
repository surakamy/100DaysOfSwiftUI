//
//  FaceView.swift
//  FaceMemos
//
//  Created by Dmytro Kholodov on 12/19/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct EditView: View {
    @State var person: Person

    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?

    
    var body: some View {
        let name = Binding<String>(
            get: {
                return self.person.wrappedName
            },
            set: { (v) in
                self.person.name = v
            })
        return
        VStack{
            ZStack {
                Image(uiImage: person.wrappedPhoto)
                .resizable()
                .aspectRatio(1, contentMode: .fit)

                Color.red.opacity(0.1)

                TextField("", text: name)
                .multilineTextAlignment(TextAlignment.center)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .offset(x: 0, y: 150)
            }

            ZStack {
                MapView(centerCoordinate: $centerCoordinate, annotations: locations, selectedPlace: $selectedPlace)

                Circle()
                    .fill(Color.red.opacity(0.95))
                .opacity(0.3)
                .frame(width: 32, height: 32)

                Circle()
                    .fill(Color.red.opacity(0.95))
                .frame(width: 12, height: 12)

            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct FaceView: View {
    @Binding var person: Person?
    var moc: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSelectView = false
    @State private var inputImage: UIImage?

    var body: some View {
        Group {
            if $person.wrappedValue != nil {
                EditView(person: self.person!)
            } else {
                Color.red.opacity(0.75).edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            if self.$person.wrappedValue == nil {
                self.showingSelectView.toggle()
            }
        }
        .sheet(isPresented: $showingSelectView, onDismiss: appendPerson) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func appendPerson() {
        guard let inputImage = inputImage else {
            presentationMode.wrappedValue.dismiss()
            return
        }
        let size = CGSize(width: 250, height: 250)

        let renderer = UIGraphicsImageRenderer(size: size)
        let sizedImage = renderer.image { (context) in
            inputImage.draw(in: CGRect(origin: .zero, size: size))
        }

        let newbie = Person(context: moc)
        newbie.name = ["si", "no", "mo", "do", "hood"].shuffled().joined()
        newbie.photo = sizedImage

        self.person = newbie
        do {
           try moc.save()
        } catch  {
            print("Error info: \(error)")
        }
    }
}


