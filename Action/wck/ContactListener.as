package wck
{
    import Box2D.Collision.*;
    import Box2D.Dynamics.*;
    import flash.events.*;

    public class ContactListener extends b2ContactListener
    {

        public function ContactListener()
        {
            return;
        }// end function

        override public function Persist(param1:b2ContactPoint) : void
        {
            dispatch(param1, "persistContact");
            return;
        }// end function

        override public function Add(param1:b2ContactPoint) : void
        {
            dispatch(param1, "addContact");
            return;
        }// end function

        public function dispatch(param1:b2ContactPoint, param2:String)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = param1.shape1.GetUserData() as EventDispatcher;
            _loc_4 = param1.shape2.GetUserData() as EventDispatcher;
            return;
        }// end function

        override public function Remove(param1:b2ContactPoint) : void
        {
            dispatch(param1, "removeContact");
            return;
        }// end function

    }
}
