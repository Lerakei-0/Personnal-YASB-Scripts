import os
import io
from PIL import ImageGrab
import win32clipboard

def copy_image_to_clipboard(img):
    output = io.BytesIO()
    img.convert("RGB").save(output, "BMP")
    bmp_data = output.getvalue()[14:]
    output.close()
    win32clipboard.OpenClipboard()
    win32clipboard.EmptyClipboard()
    win32clipboard.SetClipboardData(win32clipboard.CF_DIB, bmp_data)
    win32clipboard.CloseClipboard()

def show_toast(title, message, image_path=None):
    try:
        from winotify import Notification, audio
        toast = Notification(
            app_id="YASB Screenshot",
            title=title,
            msg=message,
            duration="short",
            icon=image_path if image_path else ""
        )
        toast.set_audio(audio.Default, loop=False)
        toast.show()
    except Exception:
        pass

dest = os.path.join(os.path.expanduser("~"), "Pictures", "Screenshots")
os.makedirs(dest, exist_ok=True)
n = len([f for f in os.listdir(dest) if f.endswith(".png")]) + 1
path = os.path.join(dest, f"Screenshot {n}.png")

img = ImageGrab.grab()
img.save(path)
copy_image_to_clipboard(img)
show_toast(
    "Screenshot taken",
    "Saved to Pictures\\Screenshots\nAlso copied to clipboard",
    image_path=path
)
