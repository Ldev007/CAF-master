using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotator : MonoBehaviour
{
    private Touch touch;
    private Vector2 touchposition;
    private Quaternion rotationy;
    private float rotatespeed = 50.0f;
    public GameObject rotatedObject;
    int x = 0;

    // Start is called before the first frame update
    public void rotate(string s)
    {
        if (s == "right")
        {
            Debug.Log("right");
            x = 1;
        }
        if (s == "left")
        {
            Debug.Log("left");
            x = 2;
        }
        if (s == "stop")
        {
            x = 0;
        }
        /*rotationy = Quaternion.Euler(
                    0f,
                    0.8f,
                    0f);
        Debug.Log(rotationy);
        transform.rotation = rotationy * transform.rotation;*/
        transform.Rotate(Vector3.forward * rotatespeed * Time.deltaTime);
        // i = i + 1;
    }
    // Update is called once per frame
    void Update()
    {

        if (x==1)
        {
            transform.Rotate(Vector3.down * rotatespeed * Time.deltaTime);
        }
        else if (x == 2)
        {
            transform.Rotate(Vector3.up * rotatespeed * Time.deltaTime);
        }
        else if (x == 0)
        {
            transform.Rotate(Vector3.up * 0 * Time.deltaTime);
        }


        if (Input.touchCount > 0)
        {
            touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Moved)
            {
                rotationy = Quaternion.Euler(
                    0f,
                    -touch.deltaPosition.x * rotatespeed,
                    0f);
                transform.rotation = rotationy * transform.rotation;
            }
        }
        //zoom(Input.GetAxis("Mouse ScrollWheel"));
    }
}
