import cv2
import numpy as np

class ObjectTracker(object):
    def __init__(self):
        self.cap = cv2.VideoCapture(0)

        # Verificar cámara
        if not self.cap.isOpened():
            print("Error al abrir la cámara")
            return

        # Leer primer frame correctamente
        _, self.frame = self.cap.read()

        cv2.namedWindow('Object Tracker')
        cv2.setMouseCallback('Object Tracker', self.mouse_event)

        self.selection = None
        self.drag_start = None
        self.tracking_state = 0
        
    def mouse_event(self, event, x, y, flags, param):
        x, y = np.int16([x, y])

        if event == cv2.EVENT_LBUTTONDOWN:
            self.drag_start = (x, y)
            self.tracking_state = 0
            
        if self.drag_start:
            if flags & cv2.EVENT_FLAG_LBUTTON:
                h, w = self.frame.shape[:2]
                xi, yi = self.drag_start
                x0, y0 = np.maximum(0, np.minimum([xi, yi], [x, y]))
                x1, y1 = np.minimum([w, h], np.maximum([xi, yi], [x, y]))
                self.selection = None
                    
                if x1 - x0 > 0 and y1 - y0 > 0:
                    self.selection = (x0, y0, x1, y1)
            else: 
                self.drag_start = None

                if self.selection is not None:
                    self.tracking_state = 1

    def start_tracking(self):
        while True:
            ret, self.frame = self.cap.read()
            if not ret:
                break

            vis = self.frame.copy()
            hsv = cv2.cvtColor(self.frame, cv2.COLOR_BGR2HSV)
            mask = cv2.inRange(hsv, np.array((0., 60., 32.)), np.array((180., 255., 255.)))

            if self.selection:
                x0, y0, x1, y1 = self.selection
                self.track_window = (x0, y0, x1 - x0, y1 - y0)
                hsv_roi = hsv[y0:y1, x0:x1]
                mask_roi = mask[y0:y1, x0:x1]
                hist = cv2.calcHist([hsv_roi], [0], mask_roi, [16], [0, 180])
                cv2.normalize(hist, hist, 0, 255, cv2.NORM_MINMAX)
                self.hist = hist.reshape(-1)

                cv2.rectangle(vis, (x0, y0), (x1, y1), (255, 0, 0), 2)

            # Verificar que existan hist y track_window
            if self.tracking_state == 1:
                self.selection = None
                hsv_backproj = cv2.calcBackProject([hsv], [0], self.hist, [0, 180], 1)
                hsv_backproj &= mask
                term_crit = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 100, 1)
                track_box, self.track_window = cv2.CamShift(hsv_backproj, self.track_window, term_crit)
                cv2.ellipse(vis, track_box, (0, 255, 0), 2)

            cv2.imshow('Object Tracker', vis)
            c = cv2.waitKey(5)
            if c == 27:
                break

        self.cap.release()
        cv2.destroyAllWindows()

if __name__ == '__main__':
    ObjectTracker().start_tracking()