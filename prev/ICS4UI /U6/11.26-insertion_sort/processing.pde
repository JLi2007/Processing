// for h = 1 to n–1  {   		 //For all items in the array except the 1st one (which is at index 0)…
//     c = h     			 //The current index of the hopper. c starts at h but will shrink as the item hops left

//     while c > 0 && a[c-1] > a[c]   {   //For as long as the hopper is not at the start of the array and the item 
//                                                         // to the hopper's left is bigger than it...
//           swap a[c] with a[c-1]                   
//           c--    			//The hopper is now one spot to the left of where it was
//     }
// }
