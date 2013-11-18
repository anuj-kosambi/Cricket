package 
{
    import wck.*;

    dynamic public class DemoView1 extends View
    {

        public function DemoView1()
        {
            __setProp_world1_DemoView1_Layer1_1();
            return;
        }// end function

        function __setProp_world1_DemoView1_Layer1_1()
        {
            try
            {
                world1["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            world1.boundsBottom = -40;
            world1.boundsLeft = -30;
            world1.boundsRight = 30;
            world1.boundsTop = 30;
            world1.doSleep = true;
            world1.gravityRadial = 0;
            world1.gravityX = 0;
            world1.gravityY = 10;
            world1.iterations = 5;
            world1.keepCenteredOn = "viewtarget";
            world1.scale = 40;
            world1.timeStep = 0.04;
            try
            {
                world1["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
