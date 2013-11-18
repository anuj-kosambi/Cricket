package 
{
    import flash.display.*;

    dynamic public class Burst_o extends MovieClip
    {

        public function Burst_o()
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
