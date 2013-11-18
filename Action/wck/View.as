package wck
{
    import flash.display.*;
    import flash.events.*;

    public class View extends MovieClip
    {
        public var orientToGravity:Boolean = true;
        public var world:Object;
        public var world1:DemoWorld1;

        public function View()
        {
            orientToGravity = true;
            return;
        }// end function

        public function initialize() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < numChildren)
            {
                
                world = getChildAt(_loc_1) as World;
                if (world)
                {
                    break;
                }
                _loc_1++;
            }
            world.create();
            addEventListener(Event.ENTER_FRAME, step, false, 0, true);
            return;
        }// end function

        public function step(event:Event) : void
        {
            if (orientToGravity && world.gravityRadial)
            {
                rotation = -90 * (world.gravityRadial / Math.abs(world.gravityRadial)) - Math.atan2(world.y, world.x) * 180 / Math.PI;
            }
            return;
        }// end function

        public function cleanUp() : void
        {
            removeEventListener(Event.ENTER_FRAME, step);
            world.cleanUp();
            return;
        }// end function

    }
}
