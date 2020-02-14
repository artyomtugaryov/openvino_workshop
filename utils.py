import numpy
import cv2

# Import some functions from matplotlib for show barcharts
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

def parse_od_output(data: dict) -> dict:
    """
    Procesed inference results of the Tensorflow model 
    and leads to the OpenVINO Inference Engine form
    """
    predictions = []
    
    # data['detection_boxes'] contains one array for one inferenced image
    # lenght of this array is number of batchs 
    num_batches = len(data['detection_boxes'])
    
    # outputs names of SSD MobileNet SSD V2
    target_layers = ['num_detections', 'detection_classes', 'detection_scores', 'detection_boxes']

    # Get inference results for each of inferenced image 
    for b in range(num_batches):
        predictions.append([])
        # Get number of detected objects
        num_detections = int(data['num_detections'][b])
        # Get predicted classes ids
        detection_classes = data['detection_classes'][b]
        # Get probabilities for predicted classes
        detection_scores = data['detection_scores'][b]
        # Get boxes for predicted objects
        detection_boxes = data['detection_boxes'][b]
        
        # Iterate by found objects
        for i in range(num_detections):
            # Create array from data for the object
            obj = [
                b, detection_classes[i], detection_scores[i],
                detection_boxes[i][1], detection_boxes[i][0],
                detection_boxes[i][3], detection_boxes[i][2]
            ]
            
            predictions[b].append(obj)
    predictions = numpy.asarray(predictions)
    # Reshape results
    new_shape = (1, 1, predictions.shape[0] * predictions.shape[1], predictions.shape[2])
    predictions = numpy.reshape(predictions, newshape=new_shape)
    
    return predictions


def draw_image(original_image: str,
               res: tuple,
               path_to_image: str,
               prob_threshold: float=0.8,
               color: tuple=(0, 255, 0)):
    """
    Takes a path to the image and bounding boxes. 
    Draws those boxes on the new image and saves it
    """
    raw_image = cv2.imread(original_image)
    initial_w = raw_image.shape[1]
    initial_h = raw_image.shape[0]
    labels_map = { 
        18: 'dog',
        17: 'cat'
    }
    for obj in res[0][0]:
        # Draw only objects when probability more than specified threshold
        if obj[2] > prob_threshold:
            xmin = int(obj[3] * initial_w)
            ymin = int(obj[4] * initial_h)
            xmax = int(obj[5] * initial_w)
            ymax = int(obj[6] * initial_h)
            class_id = int(obj[1])
            confidence = round(obj[2] * 100, 1)
            cv2.rectangle(raw_image, (xmin, ymin), (xmax, ymax), color, 2)
            det_label = labels_map[class_id] if labels_map else str(class_id)
            box_title = '{} {}%'.format(det_label, confidence)
            cv2.putText(raw_image,
                        box_title,
                        (xmin, ymin - 7),
                        cv2.FONT_HERSHEY_COMPLEX, 5, color, cv2.LINE_AA)
    cv2.imwrite(path_to_image, raw_image)
    
    
def show_performance(performance_data: dict):
    """
    Takes dictionary contains name of configurations as keys and FPS for it as values
    Plots bar chart with data
    """
    l = numpy.arange(len(performance_data))
    
    performance = [fps for _, fps in performance_data.items()]
    configurations = list(performance_data.keys())
    figsize = (3 * len(performance_data), 10)
    fig, ax = plt.subplots(figsize=figsize)
    
    bars = ax.bar(x=l, height=performance, tick_label=configurations)

    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['bottom'].set_color('#DDDDDD')
    
    ax.tick_params(bottom=False, left=False)
    ax.set_axisbelow(True)
    ax.yaxis.grid(True, color='#EEEEEE')
    ax.xaxis.grid(False)
   
    bar_color = bars[0].get_facecolor()

    for bar in bars:
      ax.text(
          bar.get_x() + bar.get_width() / 2,
          bar.get_height() + 5,
          round(bar.get_height(), 1),
          horizontalalignment='center',
          color=bar_color,
          weight='bold',
          fontsize=17
      )
    ax.set_xlabel('Configurations', labelpad=15, color='#333333')
    ax.set_ylabel('Frame per seconds', labelpad=15, color='#333333')
    ax.set_title('Performance mesuarments', pad=15, color='#333333', weight='bold')
    plt.ylim(0, max(performance)+20)
    fig.tight_layout()