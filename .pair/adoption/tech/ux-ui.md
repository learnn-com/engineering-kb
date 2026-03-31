# UX/UI

## Design System

- **@learnn/designn** is adopted as the custom design system for shared components.
- @learnn/designn v0.2.42 is installed as an external npm module from a separate repository.
- Design system ensures visual consistency across web app and extension.
- Design system is maintained separately and versioned independently.

## Web Application

### Styling Approach
- **CSS Modules** are adopted as primary component-level styling approach.
- **SASS/SCSS** is used for stylesheet preprocessing.
- **Bootstrap 4 + React Bootstrap** are present in legacy components (not for new development).
- @learnn/designn components are imported for shared UI elements.

### Layout & Responsiveness
- **Desktop-first responsive design** is adopted for the web platform.
- Layouts adapt to tablet and mobile viewports for accessibility on smaller screens.
- Responsive breakpoints follow industry-standard practices (mobile: <768px, tablet: 768-1024px, desktop: >1024px).

### Visual Design
- Brand guidelines and visual identity are established (colors, typography, spacing).
- UI follows Learnn's brand colors and design language.
- Typography is optimized for readability and accessibility.

## Mobile Applications (iOS & Android)

### Styling Approach
- **React Native StyleSheet** is adopted for native styling.
- Platform-specific adjustments are made using `Platform.select()` where necessary.
- **react-native-linear-gradient** v2.6.2 is used for gradient effects.

### Design Patterns
- Native iOS and Android design patterns are respected for platform consistency.
- Navigation follows platform conventions (Stack + Bottom Tabs via React Navigation v6.x).
- Gestures and animations use **React Native Reanimated** v3.15.3 for 60fps performance.

### Offline-First UX
- App supports offline mode with cached content (Apollo cache persist).
- Downloaded videos are playable offline via **React Native Video** v6.16.1.
- User sees clear indicators when offline with graceful degradation.

## Browser Extension (Chrome/Firefox)

### Styling Approach
- **Tailwind CSS** v4.1.2 is adopted for utility-first styling.
- **@tailwindcss/vite** v4.0.17 integrates Tailwind with Vite build process.
- **@learnn/designn** v0.2.42 provides reusable UI components (external module).

### Extension-Specific UX
- Popup UI is optimized for small viewport (default 400x600px).
- Side panel integration provides expanded workspace when needed.
- Extension follows Chrome Extension Design Guidelines for consistency.

## Accessibility

### Current State
- Basic accessibility practices are followed (semantic HTML, alt text for images).
- Keyboard navigation is supported in web app and extension.
- Color contrast meets WCAG 2.1 AA standards for readability.

### Future Improvements
- WCAG 2.1 AAA compliance is a long-term goal.
- Screen reader optimization is planned for web app.
- ARIA attributes will be added for complex interactive components.

## Content Management

- Content is managed via **Strapi v4** headless CMS.
- Content editors use Strapi admin panel for course creation, updates, and publishing.
- Content is delivered via GraphQL queries (Apollo Client) and REST APIs.
- Rich text content is rendered using Markdown with custom renderers.

## Internationalization (i18n)

### Current State
- Application is primarily in **Italian** (target audience: Italian market).
- Some UI text may be in English (developer-facing or technical content).

### Future Support
- Multi-language support is not currently adopted.
- i18n framework may be added in the future if international expansion occurs.

## User Feedback & Interaction

### Error Handling
- User-friendly error messages are displayed for all failure scenarios.
- Error boundaries catch React errors and display fallback UI.
- **Sentry** captures errors for developer investigation.

### Loading States
- Skeleton loaders are used during data fetching (e.g., `react-native-skeleton-placeholder` in mobile).
- Progress indicators show upload/download status for videos and assets.
- Optimistic UI updates improve perceived performance.

### Notifications & Alerts
- **OneSignal** v4.5.3 is used for push notifications on mobile apps.
- In-app notifications inform users of course updates, achievements, and system messages.
- Toast notifications provide feedback for user actions (success, error, info).

## Video Player UX

### Web App
- **react-player** v2.7.0 is adopted for video playback.
- Playback controls include play/pause, seek, volume, fullscreen, playback speed.
- Video progress is saved and synced across devices.

### Mobile Apps
- **React Native Video** v6.16.1 provides native video playback.
- DRM-protected content is supported for premium courses.
- Picture-in-Picture (PiP) mode is supported on iOS and Android.
- Offline video playback is available for downloaded content.

## Forms & Input Validation

- Form management uses **Formik** v2.2.0 with **Yup** validation schemas (web app).
- Real-time validation provides immediate feedback to users.
- Error messages are clear and actionable.
- Input fields use appropriate HTML5 input types (email, tel, number, etc.).

## Analytics & User Tracking

- **PostHog** tracks user interactions and feature usage (web, extension).
- **Mixpanel** and **Firebase Analytics** track mobile app behavior.
- User consent is obtained before tracking (GDPR compliance).
- Analytics dashboards inform UX improvements and feature prioritization.

## Performance Optimization

- **Code splitting** reduces initial bundle size (Vite for web, Metro for mobile).
- **Lazy loading** defers non-critical components and images.
- **Image optimization** reduces bandwidth usage (WebP format where supported).
- **Caching strategies** minimize network requests (Apollo Client, CloudFront CDN).

## Design Workflow

- Design assets are created in Figma (or similar design tool).
- Designers and developers collaborate on component specifications.
- Design system components (@learnn/designn) are versioned and released independently.
- Visual regression testing is performed via **Cypress** (web app).

## Device & Browser Support

### Web App
- **Modern browsers**: Chrome, Firefox, Safari, Edge (latest 2 versions).
- **Legacy browser support**: Internet Explorer is not supported.
- Progressive enhancement ensures core functionality works on all supported browsers.

### Mobile Apps
- **iOS**: iOS 13+ (supports iPhone 6s and newer).
- **Android**: Android 8.0+ (API level 26+).
- **Tablets**: iPad and Android tablets are supported with responsive layouts.

### Browser Extension
- **Chrome**: Version 88+ (Manifest V3).
- **Firefox**: Version 109+ (Manifest V3 compatible).

---

All user interface implementations must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
