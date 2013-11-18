package 
{
    import flash.events.*;
    import wck.*;

    dynamic public class Ball extends Ball
    {

        public function Ball()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        public function rerotate(param1)
        {
            luma_layer.rotation = -1 * this.rotation;
            return;
        }// end function

        function frame1()
        {
            addEventListener(Event.ENTER_FRAME, rerotate);
            return;
        }// end function

    }
}
