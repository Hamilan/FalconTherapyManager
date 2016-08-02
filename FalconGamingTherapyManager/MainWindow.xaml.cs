using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Timers;
using System.Windows;
using System.Windows.Forms;
using System.Windows.Interop;
using System.Windows.Media.Imaging;
using System.Windows.Media;
using Timer = System.Timers.Timer;

namespace FalconGamingTherapyManager
{
    public enum GameType
    {
        LiftingGames,
        MovingGames,
        None
    };
    
    public class GameInfo
    {
        public string name, path, args, iconFileName;
        public int activeSession;
        public GameType gameType;
        public string mainActionKey, secondActionKey;

        public GameInfo(string name, string gameType, string icon, string path, string args, string mainActionKey, string secondActionKey, int activeSession)
        {
            this.name = name;

            this.iconFileName = icon;
            this.path = path;
            this.args = args;
            this.mainActionKey = mainActionKey;
            this.secondActionKey = secondActionKey;
            switch (gameType)
            {
                case "Wrist": this.gameType = GameType.LiftingGames; break;
                case "Move": this.gameType = GameType.MovingGames; break;
                default: this.gameType= GameType.None; break;
            }
            this.activeSession = activeSession;
        }
    }

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        [DllImport("user32.dll")]
        static extern bool SetCursorPos(int x, int y);

        [DllImport("user32.dll")]
        public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

        [DllImport("user32.dll")]
        public static extern bool RegisterHotKey(IntPtr hWnd, int id, int fsModifiers, int vlc);

        [DllImport("user32.dll")]
        public static extern bool UnregisterHotKey(IntPtr hWnd, int id);

        [DllImport("user32.dll")]
        public static extern void keybd_event(byte vk, byte scan, uint flags, uint extrainfo);

        //To handle mouse events on the form
        public const int MOUSEEVENTF_LEFTDOWN = 0x02;
        public const int MOUSEEVENTF_LEFTUP = 0x04;
        private object clickStartedIn = null;
        bool windowFocused = false;

        //To trigger mouse events based on the Falcon
        bool m_mouseDown = false;
        bool m_rightDown = false;
        bool m_leftDown = false;
        bool m_upDown = false;
        bool m_downDown = false;
        bool m_hotKeyRegistered= false;
        bool m_spacebarDown = false;

        //To handle/trigger keyboard events
        const int MOUSECLICK_HOTKEY_ID = 1;
        const byte LEFT_ARROW_VK = 0x25;
        const byte LEFT_ARROW_SC = 0x4b;
        const byte RIGHT_ARROW_VK = 0x27;
        const byte RIGHT_ARROW_SC = 0x4d;
        const byte UP_ARROW_VK = 0x26;
        const byte UP_ARROW_SC = 0x48;
        const byte DOWN_ARROW_VK = 0x28;
        const byte DOWN_ARROW_SC = 0x50;
        const uint KEY_DOWN_FLAG = 0;
        const uint KEY_UP_FLAG = 2;
        
        //Constants for Falcon operation
        const float falconXMin = -0.06f;
        const float falconXMax = 0.06f;
        const float falconYMin = -0.06f;
        const float falconYMax = 0.06f;
        const float easyWeight = .2f;    //measured in Kilograms
        const float mediumWeight = .5f;
        const float hardWeight = .8f;
        const float safeMoveStartWeight = -0.5f;   //safe value to start a weight transition when in lifting mode. It holds the handle close to the center.
        const float safeLiftStartWeight = 0f;   //safe value to start a resistance transition when in moving mode. It holds the handle close to the center.

        //To play using the Falcon
        private double falcon_LiftThreshold = 0.03; //Falcon's value ranges between -.06 and 0.06
        private float max_wristRange = -6;
        private float liftingRequired = 0.75f;

        private double falcon_MoveUpThreshold = 0.03; //Falcon's value ranges between -.06 and 0.06
        private double falcon_MoveDownThreshold = 0.03; //Falcon's value ranges between -.06 and 0.06
        private double falcon_MoveLeftThreshold = 0.03; //Falcon's value ranges between -.06 and 0.06
        private double falcon_MoveRightThreshold = 0.03; //Falcon's value ranges between -.06 and 0.06
        private float max_movementUp = 0;
        private float max_movementDown = 0;
        private float max_movementLeft = 0;
        private float max_movementRight = 0;
        private float movementRequired = 0.5f;  //Percentage of maximum possible value required to play

        GameType m_gameType = GameType.None;
        Timer m_falconUpdateTimer;
        float m_falconUpdateInterval;
        float m_LiftWeight = mediumWeight;
        float m_moveResistance = mediumWeight;
        float backupWeight; //for coming back to a previous resistance when selecting the game type None
        
        //For safe weight transitions
        private float transitionTime; //milliseconds
        private long elapsedTimeForTransition = 0;
        private float initialWeight;
        private float targetWeight;
        private bool transitioningWeight = true;
        private float deltaWeight;
        private float weightBeforeAssessment;
        private float WEIGHT_fOR_ASSESSMENT = 0;
        
        //To update the image of the game selected to play
        BitmapImage noneImage = new BitmapImage();
        
        //To update the image in "How to play"
        BitmapImage falconPanImage = new BitmapImage();
        BitmapImage falconPanButtonImage = new BitmapImage();
        BitmapImage falconUpDownImage = new BitmapImage();
        BitmapImage falconUpDownButtonImage = new BitmapImage();
        BitmapImage selectAGameImage = new BitmapImage();
        BitmapImage checkImage = new BitmapImage();
        BitmapImage attentionImage = new BitmapImage();
        BitmapImage voidImage = new BitmapImage();

        Dictionary<string, string> gameArguments = new Dictionary<string, string>();
        string chromeProfileDirectory = " --profile-directory=Default";

        private string username = "Default";
        private string chosenGame = "None";
        private bool profileChanged = false;
        private bool updatingWristExtension = false;
        private bool updatingRangeOfMovement = false;
        private bool redButtonPressed = false;
        private bool loggingGame = false;
        private StreamWriter writer;
        private bool falconWorking = false;
        private int lastSessionNumber;
        private int sessionNumber;

        Dictionary<string, System.Windows.Controls.Button> gameButtons;
        Dictionary<string, GameInfo> gamesInfo = new Dictionary<string, GameInfo>();
        private System.Windows.Media.Brush StopButtonColor = System.Windows.Media.Brushes.YellowGreen;
        private System.Windows.Media.Brush enabledButtonColor = System.Windows.Media.Brushes.LightGray;
        private System.Windows.Media.Brush attentionButtonColor = (SolidColorBrush)(new BrushConverter().ConvertFrom("#FFFFF3C0"));
        private int minPercentageMovementRequired = 50;
        private int minPercentageLiftRequired = 50;

        private string wristGamesDefaultText = "For all these games, move the Falcon's handle Up to jump or lift the game character and Down to get ready for another jump or lift.";
        private string elbowGamesDefaultText = "For all these games, move the Falcon's handle Up, Down, Left, Right to move in the desired direction.";
        private int WristTabIndex = 1;
        private int ElbowTabIndex = 2;
        private bool wristExtensionUpdated;
        private bool elbowRangeUpdated;
        
        public MainWindow()
        {
            InitializeComponent();
            using (System.IO.StreamReader reader = new System.IO.StreamReader("ChromeSettings.txt"))
            {
                reader.ReadLine(); //1st line has the title "Profile:"
                chromeProfileDirectory = " --profile-directory=" + reader.ReadLine().Trim(); ;
                reader.Close();
            }
            m_falconUpdateInterval = 1000.0f / 60.0f; // 60 Hz
            m_falconUpdateTimer = new Timer(m_falconUpdateInterval);
            m_falconUpdateTimer.Elapsed += new ElapsedEventHandler((sender, e) => OnUpdateTimerEvent(sender, e, this));
            m_falconUpdateTimer.AutoReset = false;
            transitionTime = 2000 / m_falconUpdateInterval; //2 seconds

            liftThresholdTextBox.Text = "" + falcon_LiftThreshold * 100;
            moveThresholdTextBoxUp.Text = "" + falcon_MoveUpThreshold * 100;
            moveThresholdTextBoxDown.Text = "" + falcon_MoveUpThreshold * 100;
            moveThresholdTextBoxLeft.Text = "" + falcon_MoveUpThreshold * 100;
            moveThresholdTextBoxRight.Text = "" + falcon_MoveUpThreshold * 100;

            InitializeGameSettings();
            InitializeBitmapImages();
            InitializeGamesArguments();
            
            ComponentDispatcher.ThreadPreprocessMessage += ThreadPreprocessMessageMethod;
        }

        private void InitializeGameSettings()
        {
            gameButtons = new Dictionary<string, System.Windows.Controls.Button>();
            gameButtons.Add("Crazy Rider", buttonCrazyRider);
            gameButtons.Add("Funky Karts", buttonFunkyKarts);
            gameButtons.Add("Lil Mads and the Gold Skull", buttonLilMads);
            gameButtons.Add("Swooop", buttonSwooop);
            gameButtons.Add("Skater Boy", buttonSkaterBoy);
            gameButtons.Add("BMX Boy", buttonBMXBoy);
            gameButtons.Add("Botley's Bootles Coins", buttonBootleCasher);

            gameButtons.Add("Heroes of the Loot", buttonHeroes);
            gameButtons.Add("Bird Brawl", buttonBirdBrawl);
            gameButtons.Add("Looney Tunes Dash", buttonLooneyTunes);
            gameButtons.Add("Pacman", buttonPacman);
            gameButtons.Add("Save the Day", buttonSaveTheDay);

            gameButtons.Add("Wrist Speed Test", buttonWristSpeedGame);
            //gameButtons.Add("Wrist Sustained Test", buttonSustainWristGame);

            //The following lines need to be enabled and put in a loop to allow dynamic addition of buttons
            //System.Windows.Controls.Button testButton = new System.Windows.Controls.Button();
            //testButton.Content = "Test button";
            //testButton.Width = 100;
            //testButton.Height = 40;
            //System.Windows.Controls.Grid grid1 = new System.Windows.Controls.Grid();
            //grid1.Children.Add(testButton);
            //testGroupBox.Content = grid1;

            using (System.IO.StreamReader reader = new System.IO.StreamReader("GamesSettings.txt"))
            {
                string line = reader.ReadLine();
                while(true)
                {
                    //there is a problem here
                    while (line != null && line.StartsWith("Game\t") == false)
                    {
                        line = reader.ReadLine();
                    }
                    if (line == null)
                        break;
                    //Name
                    string[] tokens = line.Split('\t');
                    string newGameName = tokens[1].Trim();
                    //Game type
                    tokens = reader.ReadLine().Split('\t');
                    string newGameType = tokens[1].Trim();
                    //Icon
                    tokens = reader.ReadLine().Split('\t');
                    string icon = tokens.Length>1? tokens[1].Trim() : "";
                    //Path
                    tokens = reader.ReadLine().Split('\t');
                    string gamePath = tokens[1].Trim();
                    //Arguments
                    tokens = reader.ReadLine().Split('\t');
                    string gameArgs = " "+tokens[1].Trim();
                    //MainActionKey
                    tokens = reader.ReadLine().Split('\t');
                    string gameMainActionKey = tokens[1].Trim();
                    //SecondActionKey
                    tokens = reader.ReadLine().Split('\t');
                    string gameSecondActionKey = tokens[1].Trim();
                    //Active On Session
                    tokens = reader.ReadLine().Split('\t');
                    int gameActiveSession = int.Parse(tokens[1].Trim());
                    gamesInfo.Add(newGameName, new GameInfo(newGameName, newGameType, icon, gamePath, gameArgs, gameMainActionKey, gameSecondActionKey,gameActiveSession));

                    line = reader.ReadLine();
                    //optional for the future:
                    //create button and add to the interface under the correct GroupBox
                    //create icon and add to the interface next to the button
                }
            }
            string lineBreak = " &#x0a; ";
            //buttonCrazyRider.ToolTip = "Goal: &#x0a; to reach the end of the level avoiding obstacles (trees, rocks, birds) and cliffs. &#x0a; To play: &#x0a; Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump.";
            //buttonLilMads.ToolTip = "Goal: &#x0a; to reach the end of the level avoiding obstacles (boxes) and cliffs. &#x0a; To play: &#x0a; Move the Falcon's handle up and down to jump.";
            //buttonFunkyKarts.ToolTip = "Goal: &#x0a; to reach the end of the level collecting as many coins as possible and avoiding falling on spikes and cliffs. &#x0a; To play: &#x0a; The kart always accelerates on its own. It can climb walls and the ceiling when it has momentum. Move the Falcon's handle up and down to jump off the ground, the walls or the ceiling.";
            //buttonHeroes.ToolTip = "Goal: &#x0a; to navigate a dungeon collecting as many treasures as possible while keeping monsters at bay. Some doors in the dungeon require a key that can be found in other rooms of the dungeon. &#x0a; To play: &#x0a; Move the Falcon’s handle up, down, left or right to navigate the dungeon with the character. And press and hold the red button to attack surrounding monsters without a need to aim at them.";
            //buttonLooneyTunes.ToolTip = "Goal: &#x0a; to escape from Angry Sam and get home avoiding obstacles in the track. &#x0a; To play: &#x0a; Move the Falcon’s handle left or right to change lanes, up to jump a hole or an obstacle, and down to slide down and avoid being hit on the head.";
            //buttonPacman.ToolTip = "Goal: &#x0a; to clear up as many levels as possible. &#x0a; To play: &#x0a; Move the Falcon’s handle up, down, left or right to move the character in the desired direction, running away from the ghosts and eating all the dots in the level. Eat the big dots to make the ghost edible for a short time.";
            //buttonBirdBrawl.ToolTip = "Goal: &#x0a; to gather as many eggs as possible. &#x0a; To play: &#x0a; Move the Falcon’s handle up, down, left or right to move the character in the desired direction. Press and hold the red button to attack enemies in front of the character and find hidden eggs.";
            //buttonSaveTheDay.ToolTip = "Goal: &#x0a; to save as many people from the disaster zone as possible. &#x0a; To play: &#x0a; Move the Falcon’s handle up, down, left or right to move the helicopter in the desired direction. Touch the characters calling for help with the helicopter to rescue them. &#x0a; Once you have loaded 10 passengers, you have to unload them in one of the safe platforms.Position the helicopter in front of a fire and press and hold the red button to throw water and turn off the fire which will leave additional treasures to collect. Some areas unlock when the player has saved a determined number of people.";
            //buttonSkaterBoy.ToolTip = "Goal: &#x0a; to reach the end of the level avoiding obstacles and collecting as many trophies and coins as possible. &#x0a; To play: &#x0a; Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump.";
            //buttonSwooop.ToolTip = "Goal: &#x0a; to keep the plane flying for as long as possible. Catch as many diamonds as possible to refill the plane’s fuel and avoid obstacles in the air. &#x0a; To play: &#x0a; Move the Falcon’s handle up to elevate the plane and move it down to let it fall.";
            //buttonWristSpeedGame.ToolTip = "Goal: &#x0a; to measure the number of full wrist extensions the player can achieve in 10 seconds. &#x0a; To play: &#x0a; Move the Falcon’s handle up and down consecutively as many times as possible.";
            //buttonBootleCasher.ToolTip = "Goal: &#x0a; collect as many coins and bootles (bot pets) as possible avoiding the bombs. &#x0a; To play: &#x0a; Hold the Falcon's handle up to lift your bot and collect coins or bootles and move the handle down to avoid bombs.";
            //buttonBMXBoy.ToolTip = "Goal: &#x0a; to reach the end of the level avoiding obstacles and collecting as many trophies and coins as possible. &#x0a; To play: &#x0a; Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump.";
                
        }

        private void InitializeBitmapImages()
        {
            noneImage = new BitmapImage(new Uri("/Images/None.jpg", UriKind.RelativeOrAbsolute));

            falconPanImage = new BitmapImage(new Uri("/Images/FalconPan.png", UriKind.RelativeOrAbsolute));
            falconPanButtonImage = new BitmapImage(new Uri("/Images/FalconPanButton.png", UriKind.RelativeOrAbsolute));
            falconUpDownImage = new BitmapImage(new Uri("/Images/FalconUpDown.png", UriKind.RelativeOrAbsolute));
            falconUpDownButtonImage = new BitmapImage(new Uri("/Images/FalconUpDownButton.png", UriKind.RelativeOrAbsolute));
            selectAGameImage = new BitmapImage(new Uri("/Images/SelectAGame.png", UriKind.RelativeOrAbsolute));
            attentionImage = new BitmapImage(new Uri("/Images/exclamation.png", UriKind.RelativeOrAbsolute));
            checkImage = new BitmapImage(new Uri("/Images/checkmark.png", UriKind.RelativeOrAbsolute));
            voidImage = new BitmapImage(new Uri("/Images/null.png", UriKind.RelativeOrAbsolute));
        }
        private void InitializeGamesArguments()
        {
            foreach(GameInfo gameInfo in gamesInfo.Values)
            {
                gameArguments.Add(gameInfo.name,gameInfo.args);
            }
            //Move games
            //gameArguments.Add("Heroes of the Loot", " --app-id=dglbaehdkhggfndjofleapioemjkkbng");
            //gameArguments.Add("Save the Day", " --app-id=enmmbcfhecnpnnifkdkocjabgkjpcicl");
            //gameArguments.Add("Bird Brawl", " --app-id=kmfmnamhddafiplkkobdinpjcnidlplk");
            //gameArguments.Add("Looney Tunes Dash", " -p com.zynga.looney -a com.zynga.looney.SplashScreenActivity");// -url unknown -nl -t -name Looney Tunes Dash!");
            //gameArguments.Add("Pacman", " --app-id=ielohiojckmcdefafhjhngbflglmilip");
            ////Lift games
            //gameArguments.Add("Swooop", " --app-id=jblimahfbhdcengjfbdpdngcfcghladf");
            //gameArguments.Add("Lil Mads and the Gold Skull", " --app-id=eegcfpajlmpiddaokbgfekondbehaalm");
            ////gameArguments.Add("Crazy Rider", " --app-id=lfgcmpnnailedfapmafbigfifabfamcl");
            //gameArguments.Add("Crazy Rider", " --app=c:/CrazyRider/CrazyRider.html");
            //gameArguments.Add("Skater Boy", " -p com.game.SkaterBoy -a com.game.SkaterBoy.main"); //-p com.game.SkaterBoy -a com.game.SkaterBoy.main -url unknown -nl -t -name " & """Skater Boy"""
            //gameArguments.Add("BMX Boy", " -p com.game.BMX_Boy -a com.game.BMX_Boy.main");
            ////gameArguments.Add("Funky Karts", " --app-id=jbgibbcljlbkkeaogjofolcbakcokmie");   //For Chrome
            //gameArguments.Add("Funky Karts", " -p com.willowbrite.funkykarts -a com.willowbrite.funkykarts.FunkyKartsActivity");   //For BlueStacks
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (FalconInterface.StartHaptics())
            { 
                m_falconUpdateTimer.Start();
                falconWorking = true;
            }
            else 
            {
                falconWorking = false;
                System.Windows.MessageBox.Show(this,"There was an error trying to start communication with the Falcon. Please verify the Falcon is connected to the energy and the computer and launch this application again.", "Error communicating with the Falcon", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (profileChanged && usernameTextBlock.Content.ToString() != "Default")
            {
                if (confirmSaveChanges() == false)
                {
                    e.Cancel = true;
                    return;
                }
            } 
            if (falconWorking)
            {
                FalconInterface.StopHaptics();
            }
            if (loggingGame)
            {
                stopLogging();
            }
            
            Window window = Window.GetWindow(this);
            var wih = new WindowInteropHelper(window);
            IntPtr hWnd = wih.Handle;
            if (m_hotKeyRegistered)
            {
                UnregisterHotKey(hWnd, MOUSECLICK_HOTKEY_ID);
            }
        }

        private bool confirmSaveChanges()
        {
            MessageBoxResult result = System.Windows.MessageBox.Show(this, "Do you want to save the changes made to this profile?", "Save changes to profile?", MessageBoxButton.YesNoCancel, MessageBoxImage.Question);
            if (result == MessageBoxResult.Cancel)
            { return false; }
            if (result == MessageBoxResult.Yes)
            { saveProfile(false); }
            return true;
        }

        private void saveProfile(bool newProfile)
        {
            if (System.IO.Directory.Exists("Profiles") == false)
            {
                System.IO.Directory.CreateDirectory("Profiles");
            }
            username = usernameTextBlock.Content.ToString().Trim();
            string filePath = "Profiles/" + username + ".profile";
            if (System.IO.File.Exists(filePath))
            {
                MessageBoxResult result = MessageBoxResult.Yes;
                if (newProfile)
                    result = System.Windows.MessageBox.Show(this, "Do you want to overwrite " + usernameTextBlock.Content.ToString() + "'s profile?", "Overwrite existing profile?", MessageBoxButton.YesNoCancel, MessageBoxImage.Question);
                if (result == MessageBoxResult.Cancel)
                    return;
                if (result == MessageBoxResult.Yes)
                    System.IO.File.Delete(filePath);
            }
            if (newProfile)
            { 
                sessionNumber = 1;
                falcon_LiftThreshold = falconYMin;
                liftingRequired = 0.75f;
                m_LiftWeight = mediumWeight;
                falcon_MoveUpThreshold = 0.03;
                falcon_MoveDownThreshold = 0.03;
                falcon_MoveLeftThreshold = 0.03;
                falcon_MoveRightThreshold = 0.03;
                movementRequired = 0.5f;
                m_moveResistance = mediumWeight;
            }
            
            System.IO.StreamWriter writer = new System.IO.StreamWriter(filePath);
            writer.WriteLine("Username:");
            writer.WriteLine("\t" + username);
            writer.WriteLine("Range of wrist extension:");
            writer.WriteLine("\t" + falcon_LiftThreshold * 100);
            writer.WriteLine("Required wrist extension (%):");
            writer.WriteLine("\t" + liftingRequired * 100);
            writer.WriteLine("Falcon's weight (grams):");
            writer.WriteLine("\t" + m_LiftWeight * 1000);

            writer.WriteLine("Range of movement (Up, Down, Left, Right):");
            writer.WriteLine("\t" + falcon_MoveUpThreshold * 100);
            writer.WriteLine("\t" + falcon_MoveDownThreshold * 100);
            writer.WriteLine("\t" + falcon_MoveLeftThreshold * 100);
            writer.WriteLine("\t" + falcon_MoveRightThreshold * 100);
            writer.WriteLine("Required movement (%):");
            writer.WriteLine("\t" + movementRequired * 100);
            writer.WriteLine("Falcon's resistance (grams):");
            writer.WriteLine("\t" + m_moveResistance * 1000);

            System.DateTime time = System.DateTime.Now;
            writer.WriteLine("Last update:");
            writer.WriteLine("\t" + time.ToString("yyyy-MM-dd at HH:mm:ss"));
            writer.WriteLine("Last session number:");
            writer.WriteLine(sessionNumber);
            writer.Close();
            profileChanged = false;
            
            SaveWristSettingsButton.Background = enabledButtonColor;
            SaveElbowSettingsButton.Background = enabledButtonColor;

            if(newProfile)
                System.Windows.MessageBox.Show(this, username + "'s profile created", username + "'s profile crated", MessageBoxButton.OK, MessageBoxImage.Information);
            else
                System.Windows.MessageBox.Show(this, username + "'s profile saved", username + "'s profile saved", MessageBoxButton.OK, MessageBoxImage.Information);

            string historyFile = "Profiles/" + usernameTextBlock.Content.ToString() + "History.csv";
            bool writeTitles = true;
            if (System.IO.File.Exists(historyFile))
            {
                writeTitles = false;
            }
            System.IO.StreamWriter historyWriter = new System.IO.StreamWriter(historyFile, true);
            if (writeTitles)
            {
                historyWriter.WriteLine("TimeStamp, LiftRange, Weight, LiftRequired, MovementRangeUp, MovementRangeDown, MovementRangeLeft, MovementRangeRight, Resistance, MovementRequired");
            }

            historyWriter.WriteLine(time.ToString("yyyy-MM-dd_HH-mm-ss") + "," + falcon_LiftThreshold + "," + m_LiftWeight + "," + liftingRequired + "," + falcon_MoveUpThreshold + "," + falcon_MoveDownThreshold + "," + falcon_MoveLeftThreshold + "," + falcon_MoveRightThreshold + "," + m_moveResistance + "," + movementRequired);
            historyWriter.Close();

            if(newProfile)
            {
                openProfile(username);
            }
        }

        private void openProfile(string username)
        {
            System.IO.StreamReader reader = new System.IO.StreamReader("Profiles/"+username+".profile");
            openProfileStream( reader );
            enableOpeningOptions();
        }

        private void openProfileStream(StreamReader reader)
        {
            reader.ReadLine(); //1st line has the title "Username:"
            username = reader.ReadLine().Trim();
            usernameTextBlock.Content = username;
            reader.ReadLine(); //3rd line has the title "Range of wrist extension:"
            falcon_LiftThreshold = float.Parse(reader.ReadLine().Trim()) / 100f;
            liftThresholdTextBox.Text = "" + Math.Round(falcon_LiftThreshold, 5);
            reader.ReadLine(); //5th line has the title "Required wrist extension (%):"
            liftingRequired = float.Parse(reader.ReadLine().Trim()) / 100f;
            liftRequiredTextBox.Text = liftingRequired * 100 + "";
            liftRequiredSlider.Value = liftingRequired * 100;
            reader.ReadLine(); //7th line has the title "Falcon's weight (grams):"
            updateWeight(float.Parse(reader.ReadLine().Trim()) / 1000f);
            reader.ReadLine(); //9th line has the title "Range of movement (Up, Down, Left, Right):"
            falcon_MoveUpThreshold = float.Parse(reader.ReadLine().Trim()) / 100f;
            falcon_MoveDownThreshold = float.Parse(reader.ReadLine().Trim()) / 100f;
            falcon_MoveLeftThreshold = float.Parse(reader.ReadLine().Trim()) / 100f;
            falcon_MoveRightThreshold = float.Parse(reader.ReadLine().Trim()) / 100f;
            moveThresholdTextBoxUp.Text = "" + Math.Round(falcon_MoveUpThreshold, 5) * 100;
            moveThresholdTextBoxDown.Text = "" + Math.Round(falcon_MoveDownThreshold, 5) * 100;
            moveThresholdTextBoxLeft.Text = "" + Math.Round(falcon_MoveLeftThreshold, 5) * 100;
            moveThresholdTextBoxRight.Text = "" + Math.Round(falcon_MoveRightThreshold, 5) * 100;
            reader.ReadLine(); //14th line has the title "Required movement (%):"
            movementRequired = float.Parse(reader.ReadLine().Trim()) / 100f;
            movementRequiredTextBox.Text = movementRequired * 100 + "";
            movementRequiredSlider.Value = movementRequired * 100;
            reader.ReadLine(); //16th line has the title "Falcon's resistance (grams):"
            updateResistance(float.Parse(reader.ReadLine().Trim()) / 1000f);
            //next two lines contain the date the profile was changed
            reader.ReadLine(); //18th line
            reader.ReadLine();
            //Next two lines contain the number of the previous session
            reader.ReadLine(); //20th line has the title "Last session number:"
            lastSessionNumber = int.Parse(reader.ReadLine().Trim());
            reader.Close();
        }
        

        private void createProfileButton_Click(object sender, RoutedEventArgs e)
        {
            string buttonCaption = ((System.Windows.Controls.Button)sender).Content.ToString();
            if (buttonCaption == "Create profile")
            {
                string input = Microsoft.VisualBasic.Interaction.InputBox("Write down a name for the new profile", "Name for new profile", "P##", -1, -1).Trim();
                if (input == null || input == "")
                    return;
                if(input == "Default" )
                {
                    System.Windows.MessageBox.Show(this, "Please type a different name for the profile and try again.", "Name for the profile", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                    return;
                }
                usernameTextBlock.Content = input;
                saveProfile(true);
            }
            else
            {
                saveProfile(false);
            }
        }
        private void enableOpeningOptions()
        {
            sessionTextBlock.Content = "" + sessionNumber;
            profileChanged = false;
            disableGamesBasedOnSessionNumber();

            WristTab.IsEnabled = true;
            elbowShoulderTab.IsEnabled = true;
            
            wristRangeReadyImage.Source = attentionImage;
            moveRangeReadyImage.Source = attentionImage;
            openProfileButton.Background = enabledButtonColor;
            setWristRangeButton.Background = attentionButtonColor;
            setMoveRangeButton.Background = attentionButtonColor;
            SaveElbowSettingsButton.Background = enabledButtonColor;
            SaveWristSettingsButton.Background = enabledButtonColor;
            saveWristSettingsImage.Source = voidImage;
            saveElbowSettingsImage.Source = voidImage;
            profileOpenImage.Source = checkImage;
            step2Image.Source = attentionImage;
        }

        private void openProfileButton_Click(object sender, RoutedEventArgs e)
        {
            if (System.IO.Directory.Exists("Profiles") == false)
            {
                System.IO.Directory.CreateDirectory("Profiles");
            }
            if (profileChanged && username != "Default")
            {
                if (confirmSaveChanges() == false)
                    return;
            }
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            openFileDialog1.InitialDirectory = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + "\\Profiles\\";

            openFileDialog1.Filter = "Profiles (.profile)|*.profile";
            openFileDialog1.FilterIndex = 1;

            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                System.IO.Stream fileStream = openFileDialog1.OpenFile();

                using (System.IO.StreamReader reader = new System.IO.StreamReader(fileStream))
                {
                    openProfileStream(reader);
                    string input = Microsoft.VisualBasic.Interaction.InputBox("What's the number of this session?\nLast session was: "+lastSessionNumber, "What's the number of this session?",""+(lastSessionNumber+1), -1, -1).Trim();
                    sessionNumber = int.Parse(input);
                    if (sessionNumber != lastSessionNumber)
                        profileChanged = true;
                    enableOpeningOptions();
                }
            }
        }
        private void easyWeightButton_Click(object sender, RoutedEventArgs e)
        {
            updateWeight(easyWeight);
        }
        private void mediumWeightButton_Click(object sender, RoutedEventArgs e)
        {
            updateWeight(mediumWeight);
        }
        private void hardWeightButton_Click(object sender, RoutedEventArgs e)
        {
            updateWeight(hardWeight);
        }
        private void updateWeightButton_Click(object sender, RoutedEventArgs e)
        {
            int intWeight=0;
            if (int.TryParse(liftWeightTextBox.Text, out intWeight) == true)
                updateWeight(intWeight / 1000f);
        }
        private void liftWeightTextBox_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == System.Windows.Input.Key.Return)
            {
                updateWeightButton_Click(sender, null);
            }
        }

        private void easyResistanceButton_Click(object sender, RoutedEventArgs e)
        {
            updateResistance(easyWeight);
        }
        private void mediumResistanceButton_Click(object sender, RoutedEventArgs e)
        {
            updateResistance(mediumWeight);
        }
        private void hardResistanceButton_Click(object sender, RoutedEventArgs e)
        {
            updateResistance(hardWeight);
        }
        private void updateResistanceButton_Click(object sender, RoutedEventArgs e)
        {
            int intResistance = 0;
            if (int.TryParse(movingResistanceTextBox.Text, out intResistance) == true)
                updateResistance(intResistance / 1000f);
        }
        private void movingResistanceLabel_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == System.Windows.Input.Key.Return)
            {
                updateResistanceButton_Click(sender, null);
            }
        }

        private void startWeightTransition(float newWeight)
        {
            if(m_gameType==GameType.LiftingGames)
                initialWeight = safeLiftStartWeight;
            else
                initialWeight = safeMoveStartWeight;
            targetWeight = newWeight;
            deltaWeight = (targetWeight - initialWeight) / transitionTime;
            elapsedTimeForTransition = 0;
            transitioningWeight = true;    //dealt with in the Falcon Timer Event Handler
        }

        private void slider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            if (sender == liftingWeightSlider)
            {
                updateWeight((float)liftingWeightSlider.Value / 1000);
            }
            else if(sender == moveResistanceSlider)
            {
                updateResistance((float)moveResistanceSlider.Value / 1000);
            }
            else if (sender == liftRequiredSlider)
            {
                liftingRequired = ((float)liftRequiredSlider.Value / 100);
                liftRequiredTextBox.Text = Math.Round(liftRequiredSlider.Value) + "";
            }
            else if (sender == movementRequiredSlider)
            {
                movementRequired = (float)movementRequiredSlider.Value / 100;
                movementRequiredTextBox.Text = Math.Round(movementRequiredSlider.Value) + "";
            }
            profileChanged = true;
            if(SaveWristSettingsButton != null)
                SaveWristSettingsButton.Background = attentionButtonColor;
            if(SaveElbowSettingsButton != null)
                SaveElbowSettingsButton.Background = attentionButtonColor;
        }

        private void updateLiftingRequired()
        {
            int liftRequired = 0;
            if (int.TryParse(liftRequiredTextBox.Text, out liftRequired) == true)
            { 
                liftingRequired = liftRequired / 100f;
                liftRequiredSlider.Value = liftingRequired * 100;
            }
            SaveElbowSettingsButton.Background = attentionButtonColor;
            SaveWristSettingsButton.Background = attentionButtonColor;
        }
        private void liftRequiredTextBlock_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == System.Windows.Input.Key.Return)
            {
                updateLiftingRequired();
            }
        }
        private void updateLiftRequiredButton_Click(object sender, RoutedEventArgs e)
        {
            updateLiftingRequired();
        }

        private void updateMovementRequired()
        {
            int moveRequired = 0;
            if (int.TryParse(movementRequiredTextBox.Text, out moveRequired) == true && moveRequired >= minPercentageMovementRequired)
            {
                movementRequired = moveRequired / 100f;
                movementRequiredSlider.Value = movementRequired * 100;
            }
            SaveElbowSettingsButton.Background = attentionButtonColor;
            SaveWristSettingsButton.Background = attentionButtonColor;
        }
        private void updatePercentageMovementButton_Click(object sender, RoutedEventArgs e)
        {
            updateMovementRequired();
        }

        private void movementRequiredTextBox_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == System.Windows.Input.Key.Return)
            {
                updateMovementRequired();
            }
        }

        private void updateWeight(float newWeight)
        {
            m_LiftWeight = newWeight;
            backupWeight = m_LiftWeight;
            liftingWeightSlider.Value = newWeight*1000;
            liftWeightTextBox.Text = Math.Round(liftingWeightSlider.Value) + "";

            if (SaveElbowSettingsButton != null)
            {
                SaveElbowSettingsButton.Background = attentionButtonColor;
                SaveWristSettingsButton.Background = attentionButtonColor;
            }
            
            if (falconWorking == false)
                return;
            profileChanged = true;
            FalconInterface.SetWeight(m_LiftWeight);
        }
        private void updateResistance(float newResistance)
        {
            m_moveResistance = newResistance;
            backupWeight = m_moveResistance;
            moveResistanceSlider.Value = newResistance * 1000;
            movingResistanceTextBox.Text = Math.Round(moveResistanceSlider.Value) + "";

            if (SaveElbowSettingsButton != null)
            { 
                SaveElbowSettingsButton.Background = attentionButtonColor;
                SaveWristSettingsButton.Background = attentionButtonColor;
            }
            
            if (falconWorking == false)
                return;
            profileChanged = true;
            FalconInterface.StartRadialResist(m_moveResistance * 10);
        }

        private void changeSettingsForNone()
        {
            //elbowShoulderGamesGroupBox.IsEnabled = false;
            //elbowShoulderSettingsGroupBox.IsEnabled = false;

            //wristGamesGroupBox.IsEnabled = false;
            //wristSettingsGroupBox.IsEnabled = false;

            if (m_gameType != GameType.None)
            {
                wristGamesInstructions.Text = wristGamesDefaultText;
                elbowGamesInstructions.Text = elbowGamesDefaultText;

                m_gameType = GameType.None;
                chosenGame = "None";
                backupWeight = m_LiftWeight;
                m_LiftWeight = -0.5f;
                startWeightTransition(0);    //this thread will stop the weight once the transition is done.

                //setMoveRangeButton.IsEnabled = false;
                //setWristRangeButton.IsEnabled = false;
                //wristSettingsGroupBox.IsEnabled = false;
                //elbowShoulderSettingsGroupBox.IsEnabled = false;
                //elbowShoulderGamesGroupBox.IsEnabled = false;
                //wristGamesGroupBox.IsEnabled = false;
            }
        }

        private void changeSettingsForWeight()
        {
            //elbowShoulderGamesGroupBox.IsEnabled = false;
            //elbowShoulderSettingsGroupBox.IsEnabled = false;

            //wristSettingsGroupBox.IsEnabled = true;
            //wristGamesGroupBox.IsEnabled = true;

            if (m_gameType == GameType.None)
            {
                m_LiftWeight = backupWeight;
            }
            targetWeight = m_LiftWeight;
            m_LiftWeight = safeLiftStartWeight;
            m_gameType = GameType.LiftingGames;
            wristGamesInstructions.Text = wristGamesDefaultText;
            elbowGamesInstructions.Text = elbowGamesDefaultText;

            System.Console.WriteLine("Changed Settings for Weight");
            if (falconWorking == false)
                return;
            FalconInterface.StopRadialResist();
            FalconInterface.SetWeight(m_LiftWeight);
            startWeightTransition(targetWeight);
        }

        private void changeSettingsForResistance()
        {
            //radioButtonTurnOffResistance.FontWeight = FontWeights.Bold;

            //wristGamesGroupBox.IsEnabled = false;
            //wristSettingsGroupBox.IsEnabled = false;
            //radioButtonWristOption.FontWeight = FontWeights.Normal;

            //elbowShoulderGamesGroupBox.IsEnabled = true;
            //elbowShoulderSettingsGroupBox.IsEnabled = true;
            //radioButtonElbowShoulderOption.FontWeight = FontWeights.Bold; 

            if (m_gameType == GameType.None)
            {
                m_LiftWeight = backupWeight;
            }
            m_gameType = GameType.MovingGames;
            wristGamesInstructions.Text = wristGamesDefaultText;
            elbowGamesInstructions.Text = elbowGamesDefaultText;
            System.Console.WriteLine("Changed Settings for resistance");
            if (falconWorking == false)
                return;
            FalconInterface.StopWeight();
            FalconInterface.StartRadialResist(m_moveResistance*10);
        }

        //*********************************************************************************************************
        //Main method called in a separate thread to read the Falcon position
        private static void OnUpdateTimerEvent(Object source, ElapsedEventArgs e, MainWindow window)
        {
            Timer timer = (Timer)source;
            timer.Stop();

            if (window.falconWorking && FalconInterface.IsDeviceReady())
            {
                double x = FalconInterface.GetXPos();
                double y = FalconInterface.GetYPos();
                double z = FalconInterface.GetZPos();

                if (window.chosenGame != "None" && window.windowFocused == false)
                {
                    switch (window.m_gameType)
                    {
                        case GameType.None:
                            break;
                        case GameType.MovingGames:
                            window.MapFalconHorizontalAxisToArrowKeys(x, window);
                            window.MapFalconVerticalAxisToArrowKeys(y, window);
                            System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                            {
                                if ((System.Windows.Input.Keyboard.GetKeyStates(System.Windows.Input.Key.Space) & System.Windows.Input.KeyStates.Down) > 0)
                                {
                                    window.m_spacebarDown= true;
                                    window.redButtonPressed = true;
                                }
                                else
                                {
                                    if (window.m_spacebarDown)
                                    {
                                        // right key up
                                        keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_UP_FLAG, 0);
                                        window.m_spacebarDown = false;
                                        window.redButtonPressed = false;
                                    }
                                }
                            });
                            break;
                        case GameType.LiftingGames:
                            if (window.chosenGame == "Crazy Rider" || window.chosenGame == "Skater Boy" || window.chosenGame == "BMX Boy")
                            {
                                window.MapFalconLiftingToUpKey(y, window);
                                window.MapSpaceBarToRightArrow(window);
                            }
                            else if (window.chosenGame == "Funky Karts")
                            {
                                window.MapFalconLiftingToUpKey(y, window);
                                window.MapSpaceBarToDownKey(window);
                            }
                            else if (window.chosenGame == "Botley's Bootles Coins" || window.chosenGame == "SustainedWristAssessment")
                            {
                                window.MapFalconLiftingToUpKey(y, window);
                            }
                            else
                            {
                                window.MapFalconLiftToLeftMouseClick(y, window);
                            }
                            break;
                    }
                }
                if (window.transitioningWeight)
                {
                    window.elapsedTimeForTransition += 1;
                    window.m_LiftWeight += window.deltaWeight;
                    if (window.elapsedTimeForTransition >= window.transitionTime)
                    {
                        window.transitioningWeight = false;
                        window.elapsedTimeForTransition = 0;
                        window.m_LiftWeight = window.targetWeight;
                        if(window.m_gameType == GameType.None)
                        {
                            FalconInterface.StopWeight();
                            FalconInterface.StopRadialResist();
                        }
                    }
                    if (window.m_gameType == GameType.LiftingGames || window.m_gameType == GameType.None)
                    {
                        FalconInterface.SetWeight(window.m_LiftWeight);
                    }
                    else if (window.m_gameType == GameType.MovingGames)
                    {
                        FalconInterface.StartRadialResist(window.m_moveResistance * 10);
                    }
                }
                else if(window.updatingWristExtension)
                {
                    if (y > window.max_wristRange)
                    {
                        window.max_wristRange = (float)Math.Round(y,5);
                        System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                        {
                            window.liftThresholdTextBox.Text = "" + window.max_wristRange * 100;
                        });
                    }
                }
                else if (window.updatingRangeOfMovement)
                {
                    if (y > window.max_movementUp)
                    {
                        window.max_movementUp = (float)Math.Round(y,5);
                        System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                        {
                            window.moveThresholdTextBoxUp.Text = "" + window.max_movementUp* 100;
                        });
                    }
                    if (y < window.max_movementDown)
                    {
                        window.max_movementDown = (float)Math.Round(y, 5);
                        System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                        {
                            window.moveThresholdTextBoxDown.Text = "" + window.max_movementDown * 100;
                        });
                    }
                    if (x > window.max_movementRight)
                    {
                        window.max_movementRight = (float)Math.Round(x, 5);
                        System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                        {
                            window.moveThresholdTextBoxRight.Text = "" + window.max_movementRight * 100;
                        });
                    }
                    if (x < window.max_movementLeft)
                    {
                        window.max_movementLeft = (float)Math.Round(x, 5);
                        System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
                        {
                            window.moveThresholdTextBoxLeft.Text = "" + window.max_movementLeft * 100;
                        });
                    }
                }
                else if (window.loggingGame)
                {
                    System.DateTime time = System.DateTime.Now;
                    window.writer.WriteLine(time.ToString("yyyy-MM-dd_HH-mm-ss-fff") + "," + x + "," + y + "," + z + "," + window.minRequiredY() +","+ window.falcon_LiftThreshold + "," + window.liftingRequired + "," + window.m_LiftWeight + "," + window.falcon_MoveUpThreshold + "," + window.falcon_MoveDownThreshold + "," + window.falcon_MoveLeftThreshold + "," + window.falcon_MoveRightThreshold + "," + window.movementRequired + "," + window.m_moveResistance + "," + window.redButtonPressed);
                }
            }
            timer.Start();
        }

        private void desktopGame_Click(object sender, RoutedEventArgs e)
        {
            string buttonCaption = ((System.Windows.Controls.Button)sender).Content.ToString();
            if (buttonCaption == "Stop")
            {
                ((System.Windows.Controls.Button)sender).Content = chosenGame;
                enableAllGames((System.Windows.Controls.Button)sender);
                stopLogging();
                wristGamesInstructions.Text = wristGamesDefaultText;
                elbowGamesInstructions.Text = elbowGamesDefaultText;
            }
            else
            {
                chosenGame = buttonCaption;
                disableAllGamesButOne((System.Windows.Controls.Button)sender);
                
                string fullPath = @"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe";
                ProcessStartInfo gameProcess = new ProcessStartInfo();
                gameProcess.FileName = System.IO.Path.GetFileName(fullPath);
                gameProcess.WorkingDirectory = System.IO.Path.GetDirectoryName(fullPath);
                gameProcess.Arguments = chromeProfileDirectory;
                gameProcess.Arguments += gameArguments[chosenGame];

                if (chosenGame == "Heroes of the Loot" || chosenGame == "Save the Day" || chosenGame == "Bird Brawl" || chosenGame == "Pacman")
                {
                    //changeSettingsForRadialResist();
                    if (chosenGame == "Heroes of the Loot")
                    {
                        elbowGamesInstructions.Text = "Move the Falcon's handle in any direction (left, right, up, down) to move the character around and press the red button to shoot at surrounding enemies.";
                    }
                    else if (chosenGame == "Save the Day")
                    {
                        elbowGamesInstructions.Text = "Move the Falcon's handle in any direction (left, right, up, down) to move the helicopter around and press the red button to shoot water at the fire.";
                    }
                    else if (chosenGame == "Bird Brawl")
                    {
                        elbowGamesInstructions.Text = "Move the Falcon's handle in any direction (left, right, up, down) to move your character around and press the red button to shoot at the enemies in front of your character.";
                    }
                    else if (chosenGame == "Pacman")
                    {
                        elbowGamesInstructions.Text = "Move the Falcon's handle in any direction (left, right, up, down) to move the character around.";
                    }
                }
                else
                {
                    //changeSettingsForWristExtension();
                    if (chosenGame == "Crazy Rider")
                    {
                        wristGamesInstructions.Text = "Move the Falcon's handle Up and Down to jump and use the red button to accelerate.";
                    }
                    else if (chosenGame == "Lil Mads and the Gold Skull")
                    {
                        wristGamesInstructions.Text = "Move the Falcon's handle Up and Down to jump.";
                    }
                    else if (chosenGame == "Swooop")
                    {
                        wristGamesInstructions.Text = "Move the Falcon's handle up to lift the plane and down to let it fall.";
                    }
                }
                startLoggingGame();
                Process.Start(gameProcess);
            }
        }

        private void blueStacksGame_Click(object sender, RoutedEventArgs e)
        {
            string buttonCaption = ((System.Windows.Controls.Button)sender).Content.ToString();
            if (buttonCaption == "Stop")
            {
                ((System.Windows.Controls.Button)sender).Content = chosenGame;
                enableAllGames((System.Windows.Controls.Button)sender);
                stopLogging();
                wristGamesInstructions.Text = wristGamesDefaultText;
                elbowGamesInstructions.Text = elbowGamesDefaultText;
            }
            else
            {
                chosenGame = buttonCaption;
                disableAllGamesButOne((System.Windows.Controls.Button)sender);

                if (chosenGame == "Looney Tunes Dash")
                {
                    //changeSettingsForRadialResist();
                    elbowGamesInstructions.Text = "Move the Falcon's handle left or right to change lanes, up to jump and down to slide down.";
                }
                else if (chosenGame == "Funky Karts")
                {
                    wristGamesInstructions.Text = "Move the Falcon's handle Up and Down to jump and use the red button to smash the ground.";
                    //changeSettingsForWristExtension();
                }
                else if (chosenGame == "Skater Boy")
                {
                    //changeSettingsForWristExtension();
                    wristGamesInstructions.Text = "Lift the Falcon's handle to jump and use the red button to accelerate.";
                }
                else if (chosenGame == "BMX Boy")
                {
                    //changeSettingsForWristExtension();
                    wristGamesInstructions.Text = "Lift the Falcon's handle to jump and use the red button to accelerate.";
                }
                
                string gamePath = @"C:\Program Files (x86)\BlueStacks\HD-RunApp.exe";
                ProcessStartInfo gameProcess = new ProcessStartInfo();
                gameProcess.FileName = System.IO.Path.GetFileName(gamePath);
                gameProcess.WorkingDirectory = System.IO.Path.GetDirectoryName(gamePath);
                gameProcess.Arguments += gameArguments[chosenGame];
                Process.Start(gameProcess);
                startLoggingGame();
            }
        }

        private void buttonCustomGame_Click(object sender, RoutedEventArgs e)
        {
            string buttonCaption = ((System.Windows.Controls.Button)sender).Content.ToString();
            wristGamesInstructions.Text = wristGamesDefaultText;
            elbowGamesInstructions.Text = elbowGamesDefaultText;

            if (buttonCaption == "Stop")
            {
                ((System.Windows.Controls.Button)sender).Content = chosenGame;
                enableAllGames((System.Windows.Controls.Button)sender);
                stopLogging();
            }
            else
            {
                chosenGame = buttonCaption;
                disableAllGamesButOne((System.Windows.Controls.Button)sender);
                
                string gamePath = gamesInfo[buttonCaption].path; //"C:\Falcon BootleCasher\BootleCasher.exe";
                ProcessStartInfo gameProcess = new ProcessStartInfo();
                gameProcess.FileName = System.IO.Path.GetFileName(gamePath);
                gameProcess.WorkingDirectory = System.IO.Path.GetDirectoryName(gamePath);
                Process.Start(gameProcess);
                startLoggingGame();
            }
        }
        private void buttonWristSpeedGame_Click(object sender, RoutedEventArgs e)
        {
            handleAssessmentGameButtonClick((System.Windows.Controls.Button)sender,
                "WristAssessment",
                "Move the Falcon's handle up to get 1 point and down to get ready for another point.",
                @"C:\Falcon Click Game\FalconClick.exe");
        }
        private void buttonSustainWristGame_Click(object sender, RoutedEventArgs e)
        {
            handleAssessmentGameButtonClick((System.Windows.Controls.Button)sender,
                "SustainedWristAssessment",
                "Lift and hold the Falcon's handle to get as many points as possible.",
                @"C:\Falcon Hold Wrist Up Game\Falcon_Hold_Wrist_Up_Game.exe");
        }
        private void handleAssessmentGameButtonClick(System.Windows.Controls.Button button, string gameName, string gameInstructions, string gamePath)
        {
            if ((string)button.Content == "Stop")
            {
                updateWeight(weightBeforeAssessment);
                enableAllGames(button);
                stopLogging();

                wristSettingsGroupBox.IsEnabled = true;

                button.Content = "Start";
            }
            else
            {
                disableAllGamesButOne(button);
                button.Content = "Stop";
                chosenGame = gameName;
                wristGamesInstructions.Text = gameInstructions;

                wristSettingsGroupBox.IsEnabled = false;
                
                weightBeforeAssessment = m_LiftWeight;
                updateWeight(WEIGHT_fOR_ASSESSMENT);

                ProcessStartInfo testGameProcess = new ProcessStartInfo();
                testGameProcess.FileName = System.IO.Path.GetFileName(gamePath);
                testGameProcess.WorkingDirectory = System.IO.Path.GetDirectoryName(gamePath);
                testGameProcess.Arguments += username;
                Process.Start(testGameProcess);
                startLoggingGame();
            }
        }

        private void disableGamesBasedOnSessionNumber()
        {
            foreach (System.Windows.Controls.Button button in gameButtons.Values)
                if (gamesInfo.ContainsKey(button.Content.ToString()) && gamesInfo[button.Content.ToString()].activeSession > sessionNumber)
                {
                    button.Content = "(opens in session " + gamesInfo[button.Content.ToString()].activeSession + ")";
                    button.IsEnabled = false;
                }        
        }
        
        private void enableAllGames(System.Windows.Controls.Button enabledButton)
        {
            chosenGame = "None";

            foreach(System.Windows.Controls.Button button in gameButtons.Values)
            {
                if (gamesInfo.ContainsKey(button.Content.ToString()) && gamesInfo[button.Content.ToString()].activeSession <= sessionNumber)
                { 
                    button.IsEnabled = true;
                }
            }

            buttonWristSpeedGame.IsEnabled = true;
            //buttonSustainWristGame.IsEnabled = true;

            if (enabledButton != null)
            {
                enabledButton.Background = enabledButtonColor;
            }
        }

        private void disableAllGamesButOne(System.Windows.Controls.Button buttonToOmit)
        {
            foreach (System.Windows.Controls.Button button in gameButtons.Values)
            {
                button.IsEnabled = false;
            }

            if (buttonToOmit != null)
            {
                buttonToOmit.Content = "Stop";
                buttonToOmit.IsEnabled = true;
                buttonToOmit.Background = StopButtonColor;
            }
        }

        private void startLoggingGame()
        {
            System.DateTime time = System.DateTime.Now;
            username = usernameTextBlock.Content.ToString().Trim();
            writer = new StreamWriter("Logs/GameLog_" + username + "_" + time.ToString("yyyy-MM-dd_HH-mm-ss") + ".csv");
            writer.WriteLine("Date & Time:," + time.ToString("yyyy-MM-dd_HH-mm-ss"));
            writer.WriteLine("Game:," + chosenGame);
            writer.WriteLine("Username:," + username);
            writer.WriteLine("Time,FalconX,FalconY,FalconZ,YRequired,LiftThreshold,LiftRequired,FalconWeight,UpThreshold,DownThreshold,LeftThreshold,RightThreshold,MovementRequired,FalconResistance,RedButtonPressed");
            loggingGame = true;
        }

        private void stopLogging()
        {
            writer.WriteLine("End of log");
            writer.Close();
            loggingGame = false;
        }

        //Capturing mouse and keyboard events on the window to avoid the Falcon controlling the interface
        private void Window_PreviewKeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            //ignores keyboard inputs when the Falcon is active and the weight slider is focused.
            if (m_gameType != GameType.None && liftingWeightSlider.IsFocused)
            {
                e.Handled = true;
            }
        }

        //Mapping the falcon to the arrow keys
        private void MapFalconHorizontalAxisToArrowKeys(double falconX, MainWindow window)
        {
            if (falconX >= falcon_MoveRightThreshold*movementRequired)
            {
                if (window.m_leftDown)
                {
                    // left key up
                    keybd_event(LEFT_ARROW_VK, LEFT_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_leftDown = false;
                }
                // right key down
                keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_DOWN_FLAG, 0);
                window.m_rightDown = true;
            }
            else if (falconX <= falcon_MoveLeftThreshold*movementRequired)
            {
                if (window.m_rightDown)
                {
                    // right key up
                    keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_rightDown = false;
                }
                // left key down
                keybd_event(LEFT_ARROW_VK, LEFT_ARROW_SC, KEY_DOWN_FLAG, 0);
                window.m_leftDown = true;
            }
            else
            {
                if (window.m_leftDown)
                {
                    // left key up
                    keybd_event(LEFT_ARROW_VK, LEFT_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_leftDown = false;
                }
                if (window.m_rightDown)
                {
                    // right key up
                    keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_rightDown = false;
                }
            }
        }

        //Mapping the falcon to the arrow keys for "moving" games (possible states: pressing up, pressing down, none)
        private void MapFalconVerticalAxisToArrowKeys(double falconY, MainWindow window)
        {
            if (falconY >= falcon_MoveUpThreshold*movementRequired)
            {
                if (window.m_downDown)
                {
                    // down key up
                    keybd_event(DOWN_ARROW_VK, DOWN_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_downDown = false;
                }
                // up key down
                keybd_event(UP_ARROW_VK, UP_ARROW_SC, KEY_DOWN_FLAG, 0);
                window.m_upDown = true;
            }
            else if (falconY <= falcon_MoveDownThreshold *movementRequired)
            {
                if (window.m_upDown)
                {
                    // up key up
                    keybd_event(UP_ARROW_VK, UP_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_upDown = false;
                }
                // down key down
                keybd_event(DOWN_ARROW_VK, DOWN_ARROW_SC, KEY_DOWN_FLAG, 0);
                window.m_downDown = true;
            }
            else
            {
                if (window.m_upDown)
                {
                    // up key up
                    keybd_event(UP_ARROW_VK, UP_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_upDown = false;
                }
                if (window.m_downDown)
                {
                    // down key up
                    keybd_event(DOWN_ARROW_VK, DOWN_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_downDown = false;
                }
            }
        }

        //If Falcon's handle lifted more than the necessary lifting movement, mouse left button is clicked
        private void MapFalconLiftToLeftMouseClick(double falconY, MainWindow window)
        {
            int screenWidth = Screen.PrimaryScreen.Bounds.Width;
            int screenHeight = Screen.PrimaryScreen.Bounds.Height;

            if (falconY >= minRequiredY())
            {
                mouse_event(MOUSEEVENTF_LEFTDOWN, screenWidth >> 1, screenHeight >> 1, 0, 0);
                window.m_mouseDown = true;
            }
            else
            {
                if (window.m_mouseDown)
                {
                    mouse_event(MOUSEEVENTF_LEFTUP, screenWidth >> 1, screenHeight >> 1, 0, 0);
                    window.m_mouseDown = false;
                }
            }
        }

        //If Falcon's handle lifted more than the necessary lifting movement, key Up is triggered
        private void MapFalconLiftingToUpKey(double falconY, MainWindow window)
        {
            if (falconY >= minRequiredY() )
            {
                // up key down
                keybd_event(UP_ARROW_VK, UP_ARROW_SC, KEY_DOWN_FLAG, 0);
                window.m_upDown = true;
            }
            else {
                if (window.m_upDown)
                {
                    // up key up
                    keybd_event(UP_ARROW_VK, UP_ARROW_SC, KEY_UP_FLAG, 0);
                    window.m_upDown = false;
                }
            }
        }

        private double minRequiredY()
        {
            return falconYMin + (max_wristRange - falconYMin) * liftingRequired;
        }
        
        //Space bar is triggered by pressing the big red button
        private void MapSpaceBarToRightArrow(MainWindow window)
        {
            System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate{
                if ((System.Windows.Input.Keyboard.GetKeyStates(System.Windows.Input.Key.Space) & System.Windows.Input.KeyStates.Down) > 0)
                {
                    // right key down
                    keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_DOWN_FLAG, 0);
                    window.m_rightDown = true;
                    redButtonPressed = true;
                }
                else
                {
                    if (window.m_rightDown)
                    {
                        // right key up
                        keybd_event(RIGHT_ARROW_VK, RIGHT_ARROW_SC, KEY_UP_FLAG, 0);
                        window.m_rightDown = false;
                        redButtonPressed = false;
                    }
                }
            });
        }

        //Space bar is triggered by pressing the big red button
        private void MapSpaceBarToDownKey(MainWindow window)
        {
            System.Windows.Application.Current.Dispatcher.Invoke((Action)delegate
            {
                if ((System.Windows.Input.Keyboard.GetKeyStates(System.Windows.Input.Key.Space) & System.Windows.Input.KeyStates.Down) > 0)
                {
                    // downn key down
                    keybd_event(DOWN_ARROW_VK, DOWN_ARROW_SC, KEY_DOWN_FLAG, 0);
                    window.m_downDown = true;
                    redButtonPressed = true;
                }
                else
                {
                    if (window.m_downDown)
                    {
                        // down key up
                        keybd_event(DOWN_ARROW_VK, DOWN_ARROW_SC, KEY_UP_FLAG, 0);
                        window.m_downDown = false;
                        redButtonPressed = false;
                    }
                }
            });
        }

        

        private void ThreadPreprocessMessageMethod(ref MSG msg, ref bool handled)
        {
            if (!handled)
            {
                if (msg.message == 0x312 && msg.wParam.ToInt32() == MOUSECLICK_HOTKEY_ID)
                {
                    handled = true;
                }
            }
        }


        private void setWristRangeButton_Click(object sender, RoutedEventArgs e)
        {
            if (updatingWristExtension)
            {
                updatingWristExtension = false;
                this.setWristRangeButton.Content = "Start measure";
                this.setWristRangeButton.Background = enabledButtonColor;
                falcon_LiftThreshold = max_wristRange;
                profileChanged = true;
                SaveWristSettingsButton.Background = attentionButtonColor;
                SaveElbowSettingsButton.Background = attentionButtonColor;
                wristRangeReadyImage.Source = checkImage;

                wristExtensionUpdated = true;
                if (elbowRangeUpdated)
                    step2Image.Source = checkImage;

                wristGamesGroupBox.IsEnabled = true;
                UserTab.IsEnabled = true;
                WristTab.IsEnabled = true;
                elbowShoulderTab.IsEnabled = true;
            }
            else
            {
                updatingWristExtension = true;
                this.setWristRangeButton.Content = "Accept";
                this.setWristRangeButton.Background = StopButtonColor;
                falcon_LiftThreshold = max_wristRange = falconYMin*100;
                liftThresholdTextBox.Text = ""+falcon_LiftThreshold;

                wristGamesGroupBox.IsEnabled = false;
                WristTab.IsEnabled = false;
                UserTab.IsEnabled = false;
                elbowShoulderTab.IsEnabled = false;
            }
        }


        private void setMoveRangeButton_Click(object sender, RoutedEventArgs e)
        {
            if (updatingRangeOfMovement)
            {
                updatingRangeOfMovement = false;
                this.setMoveRangeButton.Content = "Start measure";
                this.setMoveRangeButton.Background = enabledButtonColor;
                falcon_MoveUpThreshold = max_movementUp;
                falcon_MoveDownThreshold = max_movementDown;
                falcon_MoveLeftThreshold = max_movementLeft;
                falcon_MoveRightThreshold = max_movementRight;
                
                profileChanged = true;
                SaveWristSettingsButton.Background = attentionButtonColor;
                SaveElbowSettingsButton.Background = attentionButtonColor;
                moveRangeReadyImage.Source = attentionImage;

                elbowShoulderGamesGroupBox.IsEnabled = true;
                WristTab.IsEnabled = true;
                UserTab.IsEnabled = true;
                elbowShoulderTab.IsEnabled = true;
                SaveWristSettingsButton.IsEnabled = true;
                SaveElbowSettingsButton.IsEnabled = true;
                moveRangeReadyImage.Source = checkImage;
                
                elbowRangeUpdated = true;
                if (wristExtensionUpdated)
                    step2Image.Source = checkImage;
            }
            else
            {
                updatingRangeOfMovement = true;
                this.setMoveRangeButton.Content = "Accept";
                falcon_MoveUpThreshold = 0;
                falcon_MoveDownThreshold = 0;
                falcon_MoveLeftThreshold = 0;
                falcon_MoveRightThreshold = 0;
                max_movementUp = 0;
                max_movementDown = 0;
                max_movementLeft = 0;
                max_movementRight = 0;
                moveThresholdTextBoxUp.Text = "0";
                moveThresholdTextBoxDown.Text = "0";
                moveThresholdTextBoxLeft.Text = "0";
                moveThresholdTextBoxRight.Text = "0";
                this.setMoveRangeButton.Background = StopButtonColor;

                elbowShoulderGamesGroupBox.IsEnabled = false;
                WristTab.IsEnabled = false;
                UserTab.IsEnabled = false;
                elbowShoulderTab.IsEnabled = false;
                SaveWristSettingsButton.IsEnabled = false;
                SaveElbowSettingsButton.IsEnabled = false;
            }

        }
        //Read the values recorded in the history log and display them in a text dialog.
        private void openReportButton_Click(object sender, RoutedEventArgs e)
        {
        }

        private void Window_Activated(object sender, EventArgs e)
        {
            windowFocused = true;
        }

        private void Window_Deactivated(object sender, EventArgs e)
        {
            windowFocused = false;
        }

        private void wristExerciseButton_Click(object sender, RoutedEventArgs e)
        {
            tabControl.SelectedIndex = WristTabIndex;
            changeSettingsForWeight();
        }

        private void elbowExerciseButton_Click(object sender, RoutedEventArgs e)
        {
            tabControl.SelectedIndex = ElbowTabIndex;
            changeSettingsForResistance();
        }

        private void tabControl_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            System.Console.WriteLine("Selection changed");

            if (tabControl.SelectedIndex == WristTabIndex)
            {
                changeSettingsForWeight();
            }
            else if (tabControl.SelectedIndex == ElbowTabIndex)
            {
                changeSettingsForResistance();
            }
        }
        
    }
}
