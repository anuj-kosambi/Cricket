package Box2D.Collision
{
    import Box2D.Common.*;

    public class b2Pair extends Object
    {
        public var userData:Object = null;
        public var proxyId1:uint;
        public var proxyId2:uint;
        public var status:uint;
        public var next:uint;
        public static var e_pairFinal:uint = 4;
        public static var b2_tableMask:int = b2_tableCapacity - 1;
        public static var e_pairRemoved:uint = 2;
        public static var b2_nullPair:uint = b2Settings.USHRT_MAX;
        public static var e_pairBuffered:uint = 1;
        public static var b2_nullProxy:uint = b2Settings.USHRT_MAX;
        public static var b2_tableCapacity:int = b2Settings.b2_maxPairs;

        public function b2Pair()
        {
            userData = null;
            return;
        }// end function

        public function SetBuffered() : void
        {
            status = status | e_pairBuffered;
            return;
        }// end function

        public function IsBuffered() : Boolean
        {
            return (status & e_pairBuffered) == e_pairBuffered;
        }// end function

        public function IsFinal() : Boolean
        {
            return (status & e_pairFinal) == e_pairFinal;
        }// end function

        public function ClearRemoved() : void
        {
            status = status & ~e_pairRemoved;
            return;
        }// end function

        public function SetFinal() : void
        {
            status = status | e_pairFinal;
            return;
        }// end function

        public function IsRemoved() : Boolean
        {
            return (status & e_pairRemoved) == e_pairRemoved;
        }// end function

        public function ClearBuffered() : void
        {
            status = status & ~e_pairBuffered;
            return;
        }// end function

        public function SetRemoved() : void
        {
            status = status | e_pairRemoved;
            return;
        }// end function

    }
}
