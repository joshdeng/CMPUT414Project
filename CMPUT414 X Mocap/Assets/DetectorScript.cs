using UnityEngine;
using System.Collections;
using System.IO;
using System.Collections.Generic;
using System.Text;

public class DetectorScript : MonoBehaviour {
    string text = "0";

    List<string> spatial_track = new List<string> ();
    void Update() {
        if (Input.GetKeyUp(KeyCode.S)){
            StreamWriter sw = new StreamWriter("LH.txt", true, Encoding.ASCII);
            foreach (string s in spatial_track) {
                sw.Write(s);
            }
                
            sw.Close();
        }
    }
    void OnTriggerEnter(Collider other) {
        
        text = other.name;
    }
    void OnTriggerStay() {
        print(text);
        spatial_track.Add(text);
    }
    void OnTriggerExit() {
        text = "";
    }

}
