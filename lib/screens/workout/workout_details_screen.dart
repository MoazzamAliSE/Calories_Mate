import 'package:calories_mate/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

final Map<String, String> itemVideoLinks = {
  'Crunches':
      'https://drive.google.com/uc?export=download&id=1GlH-FHP03YUsacpno7ts77NK0RtEkBvO',
  'Leg Raises':
      'https://drive.google.com/uc?export=download&id=195WnwgDFdP9ASQKoSfnvU_jRkVYpZwAa',
  'Russian Twists':
      'https://drive.google.com/uc?export=download&id=1ji-baAoZgClJDTOAQ0Z_ybbuRUjJllvK',
  'Plank':
      'https://drive.google.com/uc?export=download&id=1XheSUCCTeLhIgqEeT0pgxf--9MeRPjnj',
  'Mountain Climber':
      'https://drive.google.com/uc?export=download&id=1T6C8ohumxyBchXnPNT5JtJKHU8Bl-FQS',
  'Dumbbells Press':
      'https://drive.google.com/uc?export=download&id=1aVnUQt6RdfIb7anwJ8S1npiYkshjMNX7',
  'Lateral Raises':
      'https://drive.google.com/uc?export=download&id=1ONNtCLtiF4CqYy49atvBMrbAlmC1MShz',
  'Front Raises':
      'https://drive.google.com/uc?export=download&id=1efSBFJ0TTf4BiLGzfiGC7rfGqIMjqsh5',
  'Rear Delt Fly':
      'https://drive.google.com/uc?export=download&id=14yNlEQzypqbzBe1reE1CwAhrAu8vZZgJ',
  'Upright Rows':
      'https://drive.google.com/uc?export=download&id=1u0ArMKZ2a70k9D2CKLU8gPx5WYQofU39',
  'Barbell Curl':
      'https://drive.google.com/uc?export=download&id=d/1hlmhduf-tP0cDB2ZlDIsllUoMRkOxyDE',
  'Dumbbell Curl':
      'https://drive.google.com/uc?export=download&id=1liTcydG-57qCRfjDE4WpzTPOmQOeBBqy',
  'Hammer Curl':
      'https://drive.google.com/uc?export=download&id=1yF9WktY2-4U5QSQU6i9kLC7kgBi6R-84',
  'Preacher Curl':
      'https://drive.google.com/uc?export=download&id=1hmSOEbYyIm2UPv5jhPoo3YlzSSZuDjpN',
  'Incline Curl':
      'https://drive.google.com/uc?export=download&id=1AUSxRok1lc0dUFbXiPGBUuAGRfq0vlIB',
  'Incline Bench Press':
      'https://drive.google.com/uc?export=download&id=1L4fR4ZHH5iRxkG8SXvcRQHRKzJ3L3t0C',
  'Flat Bench Press':
      'https://drive.google.com/uc?export=download&id=1VN8-MIimpoN2FrD6nULYsXhvB8KqNLgs',
  'Decline Bench Press':
      'https://drive.google.com/uc?export=download&id=1Sx-YbfNK_uJMT_-tfjO8ly6T8XyarwvV',
  'Chest Dips':
      'https://drive.google.com/uc?export=download&id=16iasnBhv56Wbd_EGfae784R_30b6VAzv',
  'Fly Machine':
      'https://drive.google.com/uc?export=download&id=1nRsdX8w-XdRFw-TVO_gDJ7fbfSD1QJh1',
  'Triceps Dips':
      'https://drive.google.com/uc?export=download&id=1M2i8ku3wB6Z0luo3049ptxq6PFubmjTz',
  'Overhead Dumbbell':
      'https://drive.google.com/uc?export=download&id=1v577nTbTkNe1F0Cee3IFzGI8lnMVHPNR',
  'Triceps PushDown':
      'https://drive.google.com/uc?export=download&id=1J9PcXcdG7oGuwYTmzksTp6Cy_GL4lBYk',
  'Close-Grip Bench Press':
      'https://drive.google.com/uc?export=download&id=1-gmPKt1pmmlpfb5nX0A8RMEkWF9sIz6d',
  'Skull Crushers':
      'https://drive.google.com/uc?export=download&id=1-VRtQ_CXuxRnCyU4QECO4ZJEp9QQ5np7',
  'Pull-ups':
      'https://drive.google.com/uc?export=download&id=1l1_IlIbNCikGKbGZsUvrWZaOTV5nDAwC',
  'Lat Pulldowns':
      'https://drive.google.com/uc?export=download&id=1Omk5lnr6CE8fV53MoYpF5r11qgHuFJBG',
  'Bent Over Rows':
      'https://drive.google.com/uc?export=download&id=1KtFZBGHpcBuD3kp1RkPkgc8AWQZU7wVh',
  'Seated Cable Rows':
      'https://drive.google.com/uc?export=download&id=1cfl7xBN3pLgLdbmVBlfBPKXjcPO4QAB8',
  'Deadlifts':
      'https://drive.google.com/uc?export=download&id=1IZRnD3UiXPMqOCkccbPn5rA3NunjUAnl',
  'Squats':
      'https://drive.google.com/uc?export=download&id=10zjtjrAz87Ty9SPiTAGB7Sa50Yq9gmmC',
  'Leg Press':
      'https://drive.google.com/uc?export=download&id=1LTMk_nmd0woPDIL4XGwAyGZoREfQced-',
  'Walking Lunges':
      'https://drive.google.com/uc?export=download&id=1oP-LIFGa7ow1X6426G17X71B-ZMhb024',
  'Leg Curls':
      'https://drive.google.com/uc?export=download&id=1XOKKYerKclhxWOWIP95ISOIHDljqmUbg',
  'Treadmill Running':
      'https://drive.google.com/uc?export=download&id=14-A5L-oHkgc0R5GXn6OIgScbSmAv6x_a',
  'Stationary Bike':
      'https://drive.google.com/uc?export=download&id=1L6TOvWiqIWziSbjKs5GY4eM60zR5ZotK',
  'Rowing Machine':
      'https://drive.google.com/uc?export=download&id=1BO10ptVpCl474blxn_bjxqKLa679jlQj',
  'Elliptical Trainer':
      'https://drive.google.com/uc?export=download&id=1BO10ptVpCl474blxn_bjxqKLa679jlQj',
  'Standing Calf Raises':
      'https://drive.google.com/uc?export=download&id=1J82SJ7HMbLfGH5chSb3gF3AOUJSnYaqE',
  'Seated Calf Raises':
      'https://drive.google.com/uc?export=download&id=1Fz-F2rvzR6RssELHd0xhTZWNTPLyCLdh',
  'Calf Press':
      'https://drive.google.com/uc?export=download&id=1H_TxOD6TQCY8LJW8MRr3QG151LHVKfdf',
  'Box Jump':
      'https://drive.google.com/uc?export=download&id=1MQtrNe5phvXDzgX-0PKXLSfE3Rx7oX42',
};

final Map<String, String> itemDescriptions = {
  'Crunches':
      '\n• Lie on your back with your knees bent and feet flat on the floor.\n\n• Place your hands behind your head or across your chest.\n\n• Lift your upper body off the ground, contracting your abdominal muscles.\n\n• Lower your upper body back down and repeat.',
  'Leg Raises':
      '\n• Lie on your back on a flat bench or on the floor.\n\n• Keep your legs straight and lift them up towards the ceiling, keeping them together.\n\n• Slowly lower your legs back down without touching the floor and repeat.',
  'Russian Twists':
      '\n• Sit on the floor and lean back slightly, balancing on your sit bones with your knees bent and feet off the ground.\n\n• Hold a weight or a plate with both hands near your chest.\n\n• Twist your torso to the right, then to the left, while keeping your feet off the ground.',
  'Plank':
      '\n• Start in a push-up position, but with your weight on your forearms instead of your hands.\n\n• Keep your body straight and hold this position, engaging your core muscles.\n\n• Aim to hold the plank for a specific duration, gradually increasing the time as you progress.',
  'Mountain Climber':
      '\n• Start in a plank position, supporting your body on your hands and toes, with your arms fully extended and hands shoulder-width apart.\n\n• Keep your body in a straight line from head to heels, engaging your core muscles.\n\n• Begin by bringing your right knee toward your chest as if you are running in place.\n\n• Quickly switch and bring your left knee toward your chest while extending your right leg back.\n\n• Continue alternating your legs in a running motion, bringing your knees towards your chest.',
  'Dumbbells Press':
      '\n• Sit or stand with your feet shoulder-width apart.\n\n• Hold a barbell or a pair of dumbbells at shoulder height or just above.\n\n• Press the weight upward until your arms are fully extended.\n\n• Lower the weight back down to the starting position and repeat.',
  'Lateral Raises':
      '\n• Stand or sit with a dumbbell in each hand by your sides, palms facing your thighs.\n\n• Lift the weights out to the sides, keeping a slight bend in your elbows, until your arms are parallel to the floor.\n\n• Slowly lower the weights back down and repeat.',
  'Front Raises':
      '\n• Hold a dumbbell in each hand with your palms facing your thighs.\n\n• Lift the weights in front of you with a slight bend in your elbows until your arms are parallel to the floor.\n\n• Slowly lower the weights back down and repeat.',
  'Rear Delt Fly':
      '\n• Use a pec deck machine or bend at the hips with a flat back, holding dumbbells in each hand.\n\n• Start with your arms in front of you and slightly bent at the elbows.\n\n• Move your arms out to the sides, maintaining a slight bend in your elbows, to target the rear deltoids.\n\n• Slowly return to the starting position and repeat.',
  'Upright Rows':
      '\n• Stand with a slight bend in your knees and hold a barbell or a pair of dumbbells in front of your thighs, palms facing your body.\n\n• Lift the weight up towards your chin, keeping it close to your body, until its just below your chin.\n\n• Slowly lower the weight back down to the starting position and repeat.',
  'Barbell Curl':
      '\n• Stand with your feet shoulder-width apart and hold a barbell with an underhand grip (palms facing forward).\n\n• Keep your upper arms stationary and curl the barbell up towards your shoulders, contracting your biceps.\n\n• Lower the barbell back down in a controlled manner and repeat.',
  'Dumbbell Curl':
      '\n• Stand or sit with a dumbbell in each hand, arms fully extended and palms facing forward.\n\n• Curl the weights up towards your shoulders, keeping your upper arms stationary and focusing on contracting your biceps.\n\n• Slowly lower the dumbbells back down and repeat.',
  'Hammer Curl':
      '\n• Hold a dumbbell in each hand with your palms facing your thighs (neutral grip).\n\n• Curl the weights up towards your shoulders while keeping your palms facing inwards throughout the movement.\n\n• Slowly lower the dumbbells back down and repeat.',
  'Preacher Curl':
      '\n• Position yourself on a preacher curl machine or preacher curl bench with your chest against the pad and your arms extended.\n\n• Curl the weight up towards your shoulders, focusing on the biceps contraction.\n\n• Lower the weight back down under control and repeat.',
  'Incline Curl':
      '\n• Set an incline bench at a 45-degree angle.\n\n• Sit back on the bench with a dumbbell in each hand, arms fully extended and palms facing forward.\n\n• Curl the dumbbells up, keeping your upper arms stationary and focusing on the contraction of the biceps.\n\n• Slowly lower the dumbbells back down and repeat.',
  'Incline Bench Press':
      '\n• Set an incline bench at a 30-45 degree angle.\n\n• Hold a dumbbell in each hand at shoulder level with your palms facing forward.\n\n• Lower the dumbbells to the sides of your chest, then press them back up to the starting position.\n\n• Maintain a controlled motion throughout the exercise.',
  'Flat Bench Press':
      '\n• Lie flat on a bench with a barbell, grip slightly wider than shoulder-width apart.\n\n• Lower the barbell to your chest, keeping your elbows at a 90-degree angle.\n\n• Push the barbell back up to the starting position, extending your arms fully.\n\n• Repeat the movement.',
  'Decline Bench Press':
      '\n• Lie on a decline bench with your feet secured and your head lower than your body.\n\n• Grip the barbell slightly wider than shoulder-width apart and lower it to your chest.\n\n• Push the barbell back up to the starting position, extending your arms fully.\n\n• Keep your core engaged and maintain a steady pace.',
  'Chest Dips':
      '\n• Use parallel bars or a dip station.\n\n• Start at the top position with your arms fully extended and your body leaning slightly forward.\n\n• Lower your body by bending your elbows until your shoulders are below your elbows.\n\n• Push yourself back up to the starting position using your chest and triceps.',
  'Fly Machine':
      '\n• Lie on a flat bench with a dumbbell in each hand (palms facing each other) or use a chest fly machine.\n\n• Lower the dumbbells or handles to the sides until your elbows are slightly below your shoulders, feeling a stretch in your chest.\n\n• Bring the weights or handles back up to the starting position, maintaining a slight bend in your elbows.',
  'Triceps Dips':
      '\n• Position yourself on parallel bars or a sturdy surface, gripping the bars with your hands shoulder-width apart and facing forward.\n\n• Lower your body by bending your elbows until they form a 90-degree angle or slightly less.\n\n• Push yourself back up to the starting position, fully extending your arms.',
  'Triceps PushDown':
      '\n• Stand in front of a cable machine with a straight bar attached to the high pulley.\n\n• Grip the bar with both hands shoulder-width apart, palms facing down.\n\n• Extend your arms fully while keeping your upper arms stationary, engaging your triceps.\n\n• Slowly return the bar to the starting position.',
  'Close-Grip Bench Press':
      '\n• Lie on a flat bench and grip the barbell with your hands closer than shoulder-width apart.\n\n• Lower the barbell to your chest, keeping your elbows close to your body.\n\n• Push the barbell back up to the starting position, fully extending your arms.',
  'Skull Crushers':
      '\n• Lie on a flat bench with a barbell or dumbbells in your hands, arms fully extended vertically.\n\n• Lower the weight down towards your forehead, bending at the elbows.\n\n• Extend your arms back up to the starting position, fully engaging your triceps.',
  'Overhead Dumbbell':
      '\n• Stand or sit on a bench with back support, holding a dumbbell with both hands overhead.\n\n• Lower the dumbbell behind your head by bending at the elbows.\n\n• Extend your arms back up to the starting position, fully engaging your triceps.',
  'Pull-ups':
      '\n• Grip a pull-up bar with your hands slightly wider than shoulder-width apart.\n\n• Hang with your arms fully extended.\n\n• Pull yourself up until your chin is over the bar.\n\n• Lower yourself back down with control and repeat.',
  'Lat Pulldowns':
      '\n• Sit at a lat pulldown machine with a wide grip on the bar.\n\n• Pull the bar down to your chest, keeping your back straight and your elbows pointing down.\n\n• Slowly release the bar back up and repeat.',
  'Bent Over Rows':
      '\n• Stand with your feet shoulder-width apart and a slight bend in your knees.\n\n• Bend at the hips and lean forward, keeping your back straight.\n\n• Grip a barbell with an overhand grip and pull it towards your abdomen, squeezing your shoulder blades together.\n\n• Lower the barbell back down and repeat.',
  'Seated Cable Rows':
      '\n• Sit at a seated cable row machine with your feet flat on the footrests and knees slightly bent.\n\n• Grip the handles with both hands and pull them towards your torso, squeezing your shoulder blades together.\n\n• Slowly release the handles and extend your arms forward to the starting position.',
  'Deadlifts':
      '\n• Stand with your feet shoulder-width apart and your toes pointing forward.\n\n• Grip the barbell with both hands, using an overhand or mixed grip.\n\n• Lower your body, keeping your back straight and chest up, and then lift the barbell by extending your hips and standing up.\n\n• Lower the barbell back down in a controlled manner and repeat.',
  'Treadmill Running':
      '\n• Set the treadmill to your desired speed and incline.\n\n• Start jogging or running on the treadmill, engaging your leg muscles and maintaining a brisk pace.\n\n• Adjust the speed and incline to vary the intensity of your workout.',
  'Stationary Bike':
      '\n• Adjust the seat and handlebars to a comfortable height.\n\n• Pedal at a consistent and challenging pace, adjusting the resistance to increase the intensity.\n\n• Engage your leg muscles and maintain proper posture throughout the workout.',
  'Rowing Machine':
      '\n• Sit on the rowing machine with your feet secured in the foot straps.\n\n• Grab the handle and start by extending your legs, then pull the handle towards your chest, engaging your back and arm muscles.\n\n• Return to the starting position and repeat the rowing motion, focusing on maintaining a steady and controlled rhythm.',
  'Elliptical Trainer':
      '\n• Step onto the elliptical trainer and grasp the handles.\n\n• Start moving your legs in an elliptical motion while pushing and pulling the handles.\n\n• Increase the resistance or speed to challenge yourself and engage your lower and upper body muscles.',
  'Squats':
      '\n• Stand with your feet shoulder-width apart or slightly wider, toes pointed slightly outward.\n\n• Lower your body by bending at your hips and knees, keeping your chest up and back straight.\n\n• Lower yourself until your thighs are at least parallel to the ground, or as far as your mobility allows.\n\n• Push through your heels to stand back up to the starting position.',
  'Leg Press':
      '\n• Sit on the leg press machine and position your feet shoulder-width apart on the footplate.\n\n• Lower the weight by bending your knees until they form a 90-degree angle.\n\n• Push the weight back up by extending your knees and engaging your leg muscles.',
  'Walking Lunges':
      '\n• Stand with your feet shoulder-width apart.\n\n• Step forward with one foot and lower your body until your front thigh is parallel to the ground, keeping your back straight.\n\n• Push through your front heel and bring your back foot forward to step into the next lunge.\n\n• Alternate legs and continue walking lunges.',
  'Leg Curls':
      '\n• Use the leg curl machine, adjusting the settings to fit your body comfortably.\n\n• Lie face down and curl your legs, bringing the pad towards your glutes by bending at the knee.\n\n• Slowly lower the weight back down to the starting position.',
  'Standing Calf Raises':
      '\n• Stand on the edge of a step or a calf raise machine with the balls of your feet on the edge and your heels hanging off.\n\n• Slowly raise your heels as high as you can, then lower them below the step to stretch your calves.\n\n• Repeat the movement, focusing on contracting your calf muscles.',
  'Seated Calf Raises':
      '\n• Sit on a seated calf raise machine or a sturdy bench with a weight resting on your thighs.\n\n• Place the balls of your feet on the calf raise block and lower your heels as far down as you can.\n\n• Press the weight up by raising your heels as high as possible, contracting your calf muscles.',
  'Calf Press':
      '\n• Sit on the leg press machine and position your feet at shoulder-width apart on the footplate.\n\n• Lower the weight by bending your knees until they form a 90-degree angle.\n\n• Push the weight back up by extending your knees and contracting your calf muscles.',
  'Box Jump':
      '\n• Stand in front of a sturdy box or platform.\n\n• Jump onto the box using both feet and fully extend your ankles (raise your heels) as you land.\n\n• Step back down and repeat, focusing on the explosive movement of the calf muscles.',
};

final Map<String, String> itemSetRoutineTime = {
  'Crunches': '3 sets of 15-20 reps',
  'Leg Raises': '3 sets of 12-15 reps',
  'Russian Twists': '3 sets of 20 twists (10 each side)',
  'Plank': '3 sets of 30-60 seconds.',
  'Mountain Climber':
      ' 3-4 sets of 20-30 seconds (as a timed interval) or 10-15 reps per leg for each set.',
  'Dumbbells Press': '3-4 sets of 8-12 reps.',
  'Lateral Raises': '3-4 sets of 10-15 reps.',
  'Front Raises': '3-4 sets of 10-15 reps.',
  'Rear Delt Fly': '3-4 sets of 10-12 reps',
  'Upright Rows': '3-4 sets of 8-12 reps.',
  'Barbell Curl': '3-4 sets of 8-12 reps.',
  'Dumbbell Curl': '3-4 sets of 8-12 reps.',
  'Hammer Curl': '3-4 sets of 8-12 reps.',
  'Preacher Curl': '3-4 sets of 8-12 reps.',
  'Incline Curl': ' 3-4 sets of 8-12 reps.',
  'Incline Bench Press': '3-4 sets of 8-12 reps.',
  'Flat Bench Press': '3-4 sets of 8-12 reps.',
  'Decline Bench Press': '3-4 sets of 8-12 reps.',
  'Chest Dips': '3-4 sets of 8-10 reps.',
  'Fly Machine': '3-4 sets of 10-15 reps.',
  'Triceps Dips': '3-4 sets of 8-12 reps.',
  'Triceps PushDown': '3-4 sets of 10-15 reps.',
  'Close-Grip Bench Press': '3-4 sets of 8-12 reps.',
  'Skull Crushers': '3-4 sets of 8-12 reps.',
  'Overhead Dumbbell': '3-4 sets of 8-12 reps.',
  'Pull-ups': '3-4 sets of as many reps as you can do with good form.',
  'Lat Pulldowns': '3-4 sets of 8-12 reps.',
  'Bent Over Rows': '3-4 sets of 8-12 reps.',
  'Seated Cable Rows': '3-4 sets of 10-15 reps.',
  'Deadlifts': '3-4 sets of 5-8 reps.',
  'Treadmill Running':
      '20-30 minutes of continuous jogging or running at a pace that challenges you.',
  'Stationary Bike':
      '30-45 minutes of cycling at a moderate to high intensity, adjusting resistance as needed.',
  'Rowing Machine':
      '20-30 minutes of rowing at a moderate to vigorous pace, focusing on maintaining good form.',
  'Elliptical Trainer':
      '20-30 minutes of elliptical training at a moderate to high intensity, adjusting resistance as needed.',
  'Squats': '3-4 sets of 8-12 reps.',
  'Leg Press': '3-4 sets of 8-12 reps.',
  'Walking Lunges': '3-4 sets of 12-16 lunges (6-8 per leg).',
  'Leg Curls': '3-4 sets of 8-12 reps.',
  'Standing Calf Raises': '3-4 sets of 15-20 reps.',
  'Seated Calf Raises': '3-4 sets of 15-20 reps.',
  'Calf Press': '3-4 sets of 15-20 reps.',
  'Box Jump': '3-4 sets of 10-15 reps.',

  // Add routine time for other workout items here
};

class WorkoutDetailsScreen extends StatelessWidget {
  final String categoryName;

  const WorkoutDetailsScreen({super.key, required this.categoryName});

  List<String> getWorkoutItems() {
    // Define the workout items based on the selected category
    switch (categoryName) {
      case 'ABS':
        return [
          'Crunches',
          'Leg Raises',
          'Russian Twists',
          'Plank',
          'Mountain Climber'
        ];
      case 'Shoulder':
        return [
          'Dumbbells Press',
          'Lateral Raises',
          'Front Raises',
          'Rear Delt Fly',
          'Upright Rows'
        ];
      case 'Biceps':
        return [
          'Barbell Curl',
          'Dumbbell Curl',
          'Hammer Curl',
          'Preacher Curl',
          'Incline Curl'
        ];
      case 'Chest':
        return [
          'Incline Bench Press',
          'Flat Bench Press',
          'Decline Bench Press',
          'Chest Dips',
          'Fly Machine'
        ];
      case 'Triceps':
        return [
          'Triceps Dips',
          'Triceps PushDown',
          'Close-Grip Bench Press',
          'Skull Crushers',
          'Overhead Dumbbell'
        ];
      case 'Back':
        return [
          'Pull-ups',
          'Lat Pulldowns',
          'Bent Over Rows',
          'Seated Cable Rows',
          'Deadlifts'
        ];
      case 'Cardio':
        return [
          'Treadmill Running',
          'Stationary Bike',
          'Rowing Machine',
          'Elliptical Trainer',
        ];
      case 'Leg':
        return [
          'Squats',
          'Leg Press',
          'Walking Lunges',
          'Leg Curls',
          'Deadlifts'
        ];
      case 'Calf':
        return [
          'Standing Calf Raises',
          'Seated Calf Raises',
          'Calf Press',
          'Box Jump'
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> workoutItems = getWorkoutItems();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: FitnessAppTheme.white,
        backgroundColor: FitnessAppTheme.cyan,
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: workoutItems.length,
        itemBuilder: (context, index) {
          final item = workoutItems[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    itemName: item,
                    categoryName: categoryName,
                    itemDescription: itemDescriptions[item] ?? '',
                    itemRoutineTime: itemSetRoutineTime[item] ?? '',
                  ),
                ),
              );
            },
            child: WorkoutItemContainer(
              categoryName: categoryName,
              itemName: item,
            ),
          );
        },
      ),
    );
  }
}

class WorkoutItemContainer extends StatelessWidget {
  final String categoryName;
  final String itemName;

  const WorkoutItemContainer(
      {super.key, required this.categoryName, required this.itemName});

  @override
  Widget build(BuildContext context) {
    String imageFileName = 'assets/images/$itemName.png';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2.0)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              itemName,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              imageFileName,
              width: 100.0,
              height: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String itemName;
  final String categoryName;
  final String itemDescription;
  final String itemRoutineTime;

  const VideoPlayerScreen({
    super.key,
    required this.itemName,
    required this.categoryName,
    required this.itemDescription,
    required this.itemRoutineTime,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();

    final videoLink = itemVideoLinks[widget.itemName] ?? '';

    // Initialize the video controller with the video URL
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoLink));
    _videoController.initialize().then((_) {
      setState(() {});
      _videoController.play();
    }).catchError((error) {
      print("Error initializing video: $error");
    });
  }

  void skipBackward() {
    final position =
        _videoController.value.position - const Duration(seconds: 10);
    _videoController.seekTo(position);
  }

  void skipForward() {
    final position =
        _videoController.value.position + const Duration(seconds: 10);
    _videoController.seekTo(position);
  }

  void togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: FitnessAppTheme.cyan,
        title: const Text(
          'Workout Practice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          if (_videoController.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            )
          else
            const Center(child: CircularProgressIndicator()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.replay_10,
                  size: 32.0,
                  color: FitnessAppTheme.cyan,
                ),
                onPressed: skipBackward,
              ),
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 32.0,
                  color: FitnessAppTheme.cyan,
                ),
                onPressed: togglePlayPause,
              ),
              IconButton(
                icon: const Icon(
                  Icons.forward_10,
                  size: 32.0,
                  color: FitnessAppTheme.cyan,
                ),
                onPressed: skipForward,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: kElevationToShadow[1],
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Category: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            widget.categoryName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Item: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            widget.itemName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Description: ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        widget.itemDescription,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Suggested Sets and Reps: ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.itemRoutineTime,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
