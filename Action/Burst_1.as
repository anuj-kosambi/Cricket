﻿package 
{
    import flash.display.*;

    dynamic public class Burst_1 extends MovieClip
    {

        public function Burst_1()
        {
            addFrameScript(19, frame20);
            return;
        }// end function

        function frame20()
        {
            this.parent.removeChild(this);
            stop();
            return;
        }// end function

    }
}
