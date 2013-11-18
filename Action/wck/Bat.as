package wck
{

    public class Bat extends Shape
    {

        public function Bat()
        {
            return;
        }// end function

        override public function addShapes(param1:Array) : void
        {
            param1 = param1.concat(polygonListDef([[[-0.4, 73.95], [1.3, 49.15], [12.4, 180.75], [2.15, 141.45]], [[1.3, 49.15], [0.45, 3.85], [14.15, 88.45], [19.25, 129.5], [12.4, 180.75]], [[24.4, 163.7], [12.4, 180.75], [19.25, 129.5]], [[14.15, 55.15], [14.15, 88.45], [9.85, 45.75]], [[14.15, 88.45], [0.45, 3.85], [9.85, 45.75]], [[9.85, 3.85], [9.85, 45.75], [0.45, 3.85]]]));
            super.addShapes(param1);
            return;
        }// end function

    }
}
