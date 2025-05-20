---

## 👤 Author

**Abiy Hailu**  
ID NO: UGR/8730/15  
Section: 1  
Addis Ababa University (AAU), College of Technology and Built Environment (CTBE), School of Information Technology Engineering (SiTE)

---

## 📱 App Description

This Flutter app is an Album Viewer that demonstrates clean architecture and robust state management. It fetches a list of albums and their photos from the JSONPlaceholder API, displays them in a modern, scrollable interface, and allows users to view album details and associated photos. The app features local caching with Hive for offline access, Bloc for business logic, and GoRouter for smooth navigation. Broken image links from the API are automatically replaced with working placeholder images, ensuring a seamless user experience even when the original image service is unavailable.

---

## 🚀 How It Works

1. **On launch**, the app loads cached albums and photos from Hive and displays them instantly.
2. **Fetches fresh data** from the remote JSONPlaceholder API and updates the local cache.
3. **Displays albums** in a modern, Material3-inspired list with images and titles.
4. **Tap an album** to view its details and all associated photos on a separate screen.
5. **Handles errors** gracefully and works offline with cached data, thanks to Hive local storage.
6. **Dynamically replaces broken image URLs** from the API with working images from picsum.photos for a seamless experience.

---

## 📝 Notes

- The app uses the public JSONPlaceholder API, which is read-only.  
  Adding, editing, or deleting albums/photos is not supported by the API.
- The app is designed for demonstration and educational purposes.
- The app uses Hive for local caching, Bloc for state management, and GoRouter for navigation.
- Broken image links from the API are automatically replaced with working placeholder images.

---
