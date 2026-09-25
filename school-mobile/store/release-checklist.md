# Play release: content rating, signing, and what is still missing

## Content rating questionnaire

Play's rating is generated from answers, not chosen. Answer for the app **as
built**, not as intended — the questionnaire is a declaration, and a wrong
answer is a policy violation rather than a mistake.

| Question | Answer | Why |
|---|---|---|
| Category | Utility / Productivity / Communication | It is a school records client. |
| Violence, sexuality, profanity, controlled substances, gambling | **No** to all | None of it exists in the product. |
| **Does the app allow users to interact or exchange content?** | **Yes** | A guardian can reply to a message the school opened, and a student hands in homework a teacher reads. Answering No here because it "isn't really chat" is the kind of answer that gets a listing pulled. |
| Can users communicate with strangers? | **No** | Messaging is reply-only to threads staff opened, within one school. There is **no** student-to-student messaging (order 6.2, deliberate). |
| Does the app share user-provided content publicly? | **No** | Nothing is public. |
| Does the app share the user's location with other users? | **No** | Location is never collected. |
| Does the app allow purchases? | **No, currently** | The app creates a payment *intent*; the payment happens outside it. **This answer changes if in-app payment ships** — see open blocker 3. |
| Is the app designed for children? | **Partly** | Students use it. Expect Play to apply its families policy; the exclusions in order 6.2 (no peer messaging, no social, no ranking) are what make that answerable. |

Expected outcome: rated for everyone, with an "unrestricted internet" /
"users interact" note. Do not fight the note — it is accurate.

---

## Signing

Wired in `android/app/build.gradle.kts`:

- Release builds read `android/key.properties` — **gitignored**, along with
  every `.jks` and `.keystore`. See `android/key.properties.example`.
- A machine without that file still builds. It falls back to the debug key and
  **says so at configuration time**, because a build that silently produced a
  debug-signed artefact and looked like a release is how the wrong APK reaches
  a store listing.

Generate the upload key with:

```
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

**The upload key is the one credential here that cannot be rotated by us.** If
it is lost, Play Console has to reset it; if it leaks, someone else can publish
an update to a school's phones. Password manager and a sealed offline backup.

Enrol in **Play App Signing** at first upload. It is the difference between a
lost upload key being a support ticket and being the end of that listing.

---

## Not done, and why

| Item | State |
|---|---|
| **Play organisation account + D-U-N-S** | Open blocker 1. Longest lead time in the project (2–4 weeks) and nothing here can shorten it. |
| **Arabic screenshots** | Need a running build on a device or emulator. Shot list is in `listing-ar.md`. Do not screenshot real children. |
| **Privacy policy at a public URL** | Draft is in `privacy-policy.md`. Play needs a URL, and the text needs a read against the school's DPA first. |
| **Data Safety submission** | Answers are written and derived from the code in `data-safety.md`. Submission needs the account. |
| **Upload keystore** | Not generated. It must be created by whoever will hold it, not by a build script and not by me. |
| **In-app payment answer** | Open blocker 3: whether school fees may be taken outside Play Billing decides both the content rating answer and order 4.4's architecture. |

---

## Before every release

1. `flutter analyze --fatal-infos --fatal-warnings`
2. `flutter test`
3. `php artisan test` in `laravel-api`
4. `flutter build appbundle --flavor prod` — an **App Bundle**, not an APK.
5. Confirm the build was signed with the upload key: the configuration-time
   fallback message must **not** appear in the log.
6. Re-read `data-safety.md` against anything that changed in this release.
